require 'csv'
require_relative "calculable"
require_relative "game_stats"
require_relative "game_teams_factory"
require_relative "game_teams"
require_relative "games_factory"
require_relative "games"
require_relative "league_stats"
require_relative "season_stats"
require_relative "stat_tracker"
require_relative "teams_factory"
require_relative "teams"

class Season < StatTracker
  include Calculable

  attr_reader :teams, :games, :game_teams
  
  def initialize(teams_database, games_database, game_teams_database)
    class_setup(teams_database, games_database, game_teams_database)
  end

  def within_searched_season(year)
    @searched_season = []
    formatted_year = year.to_i
    @games.games.select do |game| 
      if game.season == formatted_year
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
    @game_results = Hash.new {|hash, key| hash[key] = []}
    
    @all_games.each do |game|
      @game_results[game.head_coach] << game.result
    end

    @coach_win_percentages = Hash.new(0)

    @game_results.each do |team_id, game|
      wins = game.count("WIN")
      total_games = game.count
      @coach_win_percentages[team_id] = percentage(wins, total_games)
    end
  end

  def calculate_team_shot_accuracy
    @goals = Hash.new(0)
    @shots = Hash.new(0)
    
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

  def accumulating_tackles
    @team_tackles = Hash.new(0)

    @all_games.each do |game|
      @team_tackles[game.team_id] += game.tackles
    end
  end

  def top_performer(previous_variable)
    previous_variable.max_by do |key, value|
      value
    end
  end

  def worst_performer(previous_variable)
    previous_variable.min_by do |key, value|
      value
    end
  end

  def find_team_name(team_id_hash)
    @teams.teams.find do |team|
      team.team_id == team_id_hash[0]
    end.team_name
  end

  def winningest_coach(year)
    within_searched_season(year) 
    method_setup
    accumulating_game_results
    @best_coach = top_performer(@coach_win_percentages)
    @best_coach[0]
  end

  def worst_coach(year)
    within_searched_season(year)
    method_setup
    accumulating_game_results
    @worst_coach = worst_performer(@coach_win_percentages)
    @worst_coach[0]
  end

  def most_accurate_team(year)
    within_searched_season(year)
    method_setup
    calculate_team_shot_accuracy
    @best_accuracy = top_performer(@shot_accuracy)
    find_team_name(@best_accuracy)
  end

  def least_accurate_team(year)
    within_searched_season(year)
    method_setup
    calculate_team_shot_accuracy
    @worst_accuracy = worst_performer(@shot_accuracy)
    find_team_name(@worst_accuracy)
  end

  def most_tackles(year)
    within_searched_season(year)
    method_setup
    accumulating_tackles
    @most_tackles_team = top_performer(@team_tackles)
    find_team_name(@most_tackles_team)
  end

  def fewest_tackles(year)
    within_searched_season(year)
    method_setup
    accumulating_tackles
    @least_tackles_team = worst_performer(@team_tackles)
    find_team_name(@least_tackles_team)
  end
end