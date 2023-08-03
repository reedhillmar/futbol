#./lib/league.rb
require "./lib/calculable"
require_relative 'game_teams_factory'
require_relative 'games_factory'
require_relative 'teams_factory'
require_relative 'games_teams'
require_relative 'games'
require_relative "teams"

class League
  include Calculable 

  attr_reader :teams

  def initialize
    @teams = []
  end

  def add_team(team)
    @teams << team
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    # require 'pry';binding.pry
    # Name of the team with the highest average number of goals scored per game across all seasons

    # find team_id for each team
    team_ids = @teams.map {|team| team.team_id}
    game_teams_array = GameTeamsFactory.new
    game_teams_array.create_game_teams("./fixture/game_teams_fixtures.csv")
    h = {}

    # for each game_team, find all games with matching team_id
      # for each set of games, map goals
      # use average to return goals/game across all seasons
    # find team_id with highest gpg
    
    team_ids.each_with_object({}) do |id, h|
      team_games = []
      team_games = game_teams_array.find_all {|game| game.team_id == id}

      h[id] = team_games.map {|game| game.goals}.average
    end

    best_id = h.max_by do |_, value|
      value
    end.key(0)

    @teams.each do |team|
      if team.team_id == best_id
        team.team_name
      end
    end
  end
end