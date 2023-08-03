#./lib/game.rb
require 'csv'
# require 'spec_helper'
# require_relative 'game_teams_factory'
# require_relative 'games_factory'
# require_relative 'teams_factory'
# require_relative 'games'

class GameStats
  attr_reader :year, :teams, :games, :game_teams 

  def initialize
  end

  def highest_total_score
    highest_score = []
    @games_factory.game.each do |game|
      highest_score << (game.home_goals + game.away_goals)
    end
    highest_score.max 
  end

  def lowest_total_score
    lowest_score = []
    @games_factory.game.each do |game|
      lowest_score << (game.home_goals + game.away_goals)
    end
    lowest_score.min 
  end

  def percentage_home_wins
    home_wins = 0 
    @games_factory.game.each do |game|
      if game.home_goals > game.away_goals
        home_wins += 1
      end
    end
      percentage_wins = (home_wins.to_f / @games.count.to_f) * 100
      percentage_wins.round(2)
  end

  def percentage_visitor_wins
    visit_wins = 0 
    @games_factory.game.each do |game|
      if game.away_goals > game.home_goals
        visit_wins += 1
      end
    end
      percentage_wins = (visit_wins.to_f / @games.count.to_f) * 100
      percentage_wins.round(2)
  end

  def percentage_ties
    ties = @games_factory.game.count do |game|
      game.away_goals == game.home_goals
    end
    (ties.to_f / @games.length).round(2)
  end

  def average_goals_per_game
    all_goals = []
    @games_factory.games.each do |game|
      all_goals << game[:away_goals].to_i + game[:home_goals].to_i
    end
    total_goals = all_goals.sum
    amount_of_games = all_goals.count
    average_goals = total_goals.to_f / amount_of_games
    average_goals.round(2)
  end

  # def count_of_games_by_season
  #   games_by_season = {}
  #   @games_factory.games.each do |game|
  #     if games_by_season[game[:season]] != nil 
  #       games_by_season[game[:season]] += 1
  #     else 
  #       games_by_season[game[:season]] = 1
  #     end 
  #   end 
  #   games_by_season
  # end

  # def average_goals_by_season
  #   goals_by_season = Hash.new(0)
  #   @games_factory.games.each do |game|
  #     goals_by_season[game[:season]] = []
  #   end
  #   @games_factory.games.each do |game|
  #     all_goals = game[:away_goals].to_i + game[:home_goals].to_i
  #     goals_by_season[game[:season]]<< all_goals
  #   end
  #   goals_by_season.transform_values! {|v| v.sum.to_f / v.count}
  #   goals_by_season.transform_values! {|v| v.round(2)}
  # end
end