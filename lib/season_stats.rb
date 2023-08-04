require 'csv'
require 'spec_helper'
require_relative 'game_teams_factory'
require_relative 'games_factory'
require_relative 'teams_factory'
require_relative 'games'
require_relative 'calculable'

class Season
  include Calculable
attr_reader :year, :teams, :games, :game_teams, :searched_season
  def initialize(year,teams_database, games_database, game_teams_database)
    @year = year
    @teams = TeamsFactory.new
    @teams.create_teams(teams_database)
    @games = GamesFactory.new
    @games.create_games(games_database)
    @game_teams = GameTeamsFactory.new
    @game_teams.create_game_teams(game_teams_database)
    @searched_season = []
    within_searched_season
    
  end

  def within_searched_season
    @games.games.select do |game| 
      if game.season == @year
      @searched_season << game
      end
    end
  end

  def method_setup
    @find_game_ids = []
    @searched_season.each do |game|
      @find_game_ids << game.game_id
    end
    @all_games = @game_teams.game_teams.find_all do |game_team|
      @find_game_ids.include?(game_team.game_id)
    end
  end

  def accumulating_game_results
    @all_games.each do |game|
      @game_results[game.team_id] << game.result
    end
  end

  def calculate_team_shot_accuracy
    @all_games.each do |game|
      @goals[game.team_id] += game.goals
      @shots[game.team_id] += game.shots
    end

    @shot_accuracy = Hash.new(0)

    @goals.each do |team_id,goals|
      shots = @shots[team_id]
      @shot_accuracy[team_id] = percentage(goals, shots)
    end
  end

  def winningest_coach
    @game_results = Hash.new {|hash, key| hash[key] = []}
    
    method_setup
    accumulating_game_results

    @team_win_percentages = Hash.new(0)
    @game_results.each do |team_id, game|
      wins = game.count("WIN")
      total_games = game.count
      @team_win_percentages[team_id] = percentage(wins, total_games)
    end

    @best_team = @team_win_percentages.max_by do |team_id, percentage|
      percentage
    end
  
    @best_team_team_name = @game_teams.game_teams.find do |team|
      team.team_id == @best_team[0]
    end.head_coach
  end

  def worst_coach
    @game_results = Hash.new {|hash, key| hash[key] = []}
    
    method_setup
    accumulating_game_results

    @team_win_percentages = Hash.new(0)
    @game_results.each do |team_id, game|
      wins = game.count("WIN")
      total_games = game.count
      @team_win_percentages[team_id] = percentage(wins, total_games)
    end

    @worst_team = @team_win_percentages.min_by do |team_id, percentage|
      percentage
    end
  
    @worst_team_team_name = @game_teams.game_teams.find do |team|
      team.team_id == @worst_team[0]
    end.head_coach
  end

  #Best ratio of shots to goals
  def most_accurate_team
    @goals = Hash.new(0)
    @shots = Hash.new(0)
    
    method_setup
    calculate_team_shot_accuracy

    
    @best_accuracy = @shot_accuracy.max_by do |team_id, percentage|
      percentage
    end
  
    @best_accuracy_team_name = @teams.teams.find do |team|
      team.team_id == @best_accuracy[0]
    end.team_name

  end

  def least_accurate_team
    @goals = Hash.new(0)
    @shots = Hash.new(0)
    
    method_setup
    calculate_team_shot_accuracy

    @worst_accuracy = @shot_accuracy.min_by do |team_id, percentage|
      percentage
    end
  
    @worst_accuracy_team_name = @teams.teams.find do |team|
      team.team_id == @worst_accuracy[0]
    end.team_name
  end

  def most_tackles

  @team_tackles = Hash.new(0)
  
  method_setup

  @all_games.each do |game|
    @team_tackles[game.team_id] += game.tackles
  end
  
  @most_tackles_team = @team_tackles.max_by do |team_id, tackles|
    tackles
  end

  @most_tackles_team_name = @teams.teams.find do |team|
    team.team_id == @most_tackles_team[0]
  end.team_name

  #Later print a message that mentions goals
  end

  def fewest_tackles
  @team_tackles = Hash.new(0)
  
  method_setup

  @all_games.each do |game|
    @team_tackles[game.team_id] += game.tackles
  end
  
  @least_tackles_team = @team_tackles.min_by do |team_id, tackles|
    tackles
  end

  @least_tackles_team_name = @teams.teams.find do |team|
    team.team_id == @least_tackles_team[0]
  end.team_name
  end
end

