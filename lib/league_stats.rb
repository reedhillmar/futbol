#./lib/league.rb
require "./lib/calculable"
require_relative 'game_teams_factory'
require_relative 'teams_factory'
require_relative 'game_teams'
require_relative "teams"

class League
  include Calculable 

  attr_reader :teams, :games, :game_teams, :team_ids

  def initialize(teams_database, games_database, game_teams_database)
    @teams = TeamsFactory.new
    @teams.create_teams(teams_database)
    @game_teams = GameTeamsFactory.new
    @game_teams.create_game_teams(game_teams_database)
    @team_ids = find_team_ids
  end

  def count_of_teams
    @teams.teams.count
  end

  def best_offense
    h = average_goals("total")
    @teams.teams.find_all do |team|
      best_ids(h).include?(team.team_id)
    end.map do |team|
      team.team_name
    end.join(", ")
  end

  def worst_offense
    h = average_goals("total")
    @teams.teams.find_all do |team|
      worst_ids(h).include?(team.team_id)
    end.map do |team|
      team.team_name
    end.join(", ")
  end

  def highest_scoring_visitor
    h = average_goals("away")
    @teams.teams.find_all do |team|
      best_ids(h).include?(team.team_id)
    end.map do |team|
      team.team_name
    end.join(", ")
  end

  def highest_scoring_home_team
    h = average_goals("home")
    @teams.teams.find_all do |team|
      best_ids(h).include?(team.team_id)
    end.map do |team|
      team.team_name
    end.join(", ")
  end

  def lowest_scoring_visitor
    h = average_goals("away")
    @teams.teams.find_all do |team|
      worst_ids(h).include?(team.team_id)
    end.map do |team|
      team.team_name
    end.join(", ")
  end

  def lowest_scoring_home_team
    h = average_goals("home")
    @teams.teams.find_all do |team|
      worst_ids(h).include?(team.team_id)
    end.map do |team|
      team.team_name
    end.join(", ")
  end

  def find_team_ids
    @team_ids = @teams.teams.map {|team| team.team_id}
  end

  def average_goals(hoa)
    @team_ids.each_with_object({}) do |id, h|
      team_games = @game_teams.game_teams.find_all {|game| game.team_id == id && (hoa == "total" || game.hoa == hoa)}
      if !team_games.empty?
        h[id] = average(team_games.map {|game| game.goals})
      else
        h[id] = nil
      end
    end
  end

  def best_value(h)
    h.max_by do |_, value|
      if value != nil
        value
      else
        0
      end
    end[1]
  end

  def worst_value(h)
    h.min_by do |_, value|
      if value != nil
        value
      else
        100
      end
    end[1]
  end

  def best_ids(h)
    h.flat_map do |id, value|
      if value == best_value(h)
        id
      else
        []
      end
    end
  end

  def worst_ids(h)
    h.flat_map do |id, value|
      if value == worst_value(h)
        id
      else
        []
      end
    end
  end

  def best_teams(h)
    @teams.teams.find_all do |team|
      best_ids(h).include?(team.team_id)
    end.map do |team|
      team.team_name
    end.join(", ")
  end

  def worst_teams(h)
    @teams.teams.find_all do |team|
      worst_ids(h).include?(team.team_id)
    end.map do |team|
      team.team_name
    end.join(", ")
  end
end
