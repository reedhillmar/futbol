#./lib/season.rb
require 'csv'
require 'spec_helper'
require_relative 'game_teams_factory'
require_relative 'games_factory'
require_relative 'teams_factory'
require_relative 'games'
require_relative 'calculable'

class Season
  include Calculable
  

  # season, game_id      'games_fixtures'
  # game_id, team_id, tackles   'games_teams_fixtures'
  # team_id, franchiseId 'teams.csv'
attr_reader :year, :teams, :games, :game_teams, :searched_season
  def initialize(year)
    #Add database arguments later
    @year = year
    @teams = TeamsFactory.new
    @teams.create_teams('./data/teams.csv')
    @games = GamesFactory.new
    @games.create_games('./fixture/games_fixtures.csv')
    @game_teams = GameTeamsFactory.new
    @game_teams.create_game_teams('./fixture/game_teams_fixtures.csv')
    @game_teams
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

  def winningest_coach
  end

  def worst_coach
  end

  #Best ratio of shots to goals
  def most_accurate_team
    @goals = Hash.new(0)
    @shots = Hash.new(0)
    @find_game_ids = []
    @searched_season.each do |game|
      @find_game_ids << game.game_id
    end
    
    @all_games = @game_teams.game_teams.select do |game_team|
      @find_game_ids.each do |game|
        game_team.team_id == game
      end
    end
    @all_games.each do |game|
      @goals[game.team_id] += game.goals
      @shots[game.team_id] += game.shots
    end

    @shot_accuracy = Hash.new(0)

    @goals.each do |team_id,goals|
      shots = @shots[team_id]
      @shot_accuracy[team_id] = percentage(goals, shots)
    end


    
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
    @find_game_ids = []
    @searched_season.each do |game|
      @find_game_ids << game.game_id
    end
    
    @all_games = @game_teams.game_teams.select do |game_team|
      @find_game_ids.each do |game|
        game_team.team_id == game
      end
    end
    @all_games.each do |game|
      @goals[game.team_id] += game.goals
      @shots[game.team_id] += game.shots
    end

    @shot_accuracy = Hash.new(0)

    @goals.each do |team_id,goals|
      shots = @shots[team_id]
      @shot_accuracy[team_id] = percentage(goals, shots)
    end


    
    @worst_accuracy = @shot_accuracy.min_by do |team_id, percentage|
      percentage
    end
  
    @worst_accuracy_team_name = @teams.teams.find do |team|
      team.team_id == @worst_accuracy[0]
    end.team_name
  end
#most tackles in a season
  def most_tackles

  @team_tackles = Hash.new(0)
  @find_game_ids = []
  @searched_season.each do |game|
    @find_game_ids << game.game_id
  end
  
  @all_games = @game_teams.game_teams.select do |game_team|
    @find_game_ids.each do |game|
      game_team.team_id == game
    end
  end

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
  @find_game_ids = []
  @searched_season.each do |game|
    @find_game_ids << game.game_id
  end
  
  @all_games = @game_teams.game_teams.select do |game_team|
    @find_game_ids.each do |game|
      game_team.team_id == game
    end
  end

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
