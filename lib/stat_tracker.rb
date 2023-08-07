#./lib/stat_tracker.rb
require_relative 'game_stats'
require_relative 'league_stats'
require_relative 'season_stats'
require_relative 'game_teams_factory'
require_relative 'games_factory'
require_relative 'teams_factory'
require_relative 'game_teams'
require_relative 'games'
require_relative 'teams'

class StatTracker
  attr_reader :game_stats, :league_stats, :season_stats
  def initialize(locations)
    @game_stats = GameStats.new(locations[:teams], locations[:games], locations[:game_teams])
    @league_stats = League.new(locations[:teams], locations[:games], locations[:game_teams])
    @season_stats = Season.new(locations[:teams], locations[:games], locations[:game_teams])
  end

  #We may need to initialize objects from the game, season, and league classes here
  # ie game_stats = Game.new(insert arguments here)
  # league_stats = League.new(arguments)
  # season_stats = Season.new(arguments)

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    game_stats.highest_total_score
  end

  def lowest_total_score
    game_stats.lowest_total_score
  end

  def percentage_home_wins
    game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    game_stats.percentage_visitor_wins
  end

  def percentage_ties
    game_stats.percentage_ties
  end

  def count_of_games_by_season
    game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    game_stats.average_goals_per_game
  end

  def average_goals_by_season
    game_stats.average_goals_by_season
  end
  
  def count_of_teams
    league_stats.count_of_teams
  end

  def best_offense
    league_stats.best_offense
  end

  def worst_offense
    league_stats.worst_offense
  end

  def highest_scoring_visitor
    league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    league_stats.lowest_scoring_visitor
  end

  def winningest_coach(season)
    season_stats.winningest_coach(season)
  end

  def worst_coach(season)
    season_stats.worst_coach(season)
  end

  def most_accurate_team(season)
    season_stats.most_accurate_team(season)
  end

  def least_accurate_team(season)
    season_stats.least_accurate_team(season)
  end

  def most_tackles(season)
    season_stats.most_tackles(season)
  end

  def fewest_tackles(season)
    season_stats.fewest_tackles(season)
  end

end