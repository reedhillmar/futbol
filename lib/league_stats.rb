#./lib/league.rb
require "./lib/calculable"
require_relative 'game_teams_factory'
require_relative 'games_factory'
require_relative 'teams_factory'
require_relative 'game_teams'
require_relative 'games'
require_relative "teams"

class League
  include Calculable 

  attr_reader :teams, :games, :game_teams

  def initialize(teams_database, games_database, game_teams_database)
    @teams = TeamsFactory.new
    @teams.create_teams(teams_database)
    @games = GamesFactory.new
    @games.create_games(games_database)
    @game_teams = GameTeamsFactory.new
    @game_teams.create_game_teams(game_teams_database)
  end

  # def add_team(team)
  #   @teams << team
  # end

  def count_of_teams
    @teams.teams.count
  end

  def best_offense
    # Name of the team with the highest average number of goals scored per game across all seasons

    # find team_id for each team
    team_ids = @teams.teams.map {|team| team.team_id}
    # game_teams_array = GameTeamsFactory.new
    # game_teams_array.create_game_teams("./fixture/game_teams_fixtures.csv")

    # for each game_team, find all games with matching team_id
      # for each set of games, map goals
      # use average to return goals/game across all seasons
    # find team_id with highest gpg
    
    h = team_ids.each_with_object({}) do |id, h|
      team_games = @game_teams.game_teams.find_all {|game| game.team_id == id}
      if !team_games.empty?
        h[id] = average(team_games.map {|game| game.goals})
      else
        h[id] = nil
      end
    end
    best_id = h.max_by do |_, value|
      if value != nil
        value
      else
        0
      end
    end[0]
    @teams.teams.find do |team|
      team.team_id == best_id
    end.team_name
  end

  def worst_offense
    # Name of the team with the lowest average number of goals scored per game across all seasons

    # find team_id for each team
    team_ids = @teams.teams.map {|team| team.team_id}
    # game_teams_array = GameTeamsFactory.new
    # game_teams_array.create_game_teams("./fixture/game_teams_fixtures.csv")

    # for each game_team, find all games with matching team_id
      # for each set of games, map goals
      # use average to return goals/game across all seasons
    # find team_id with lowest gpg
    
    h = team_ids.each_with_object({}) do |id, h|
      team_games = @game_teams.game_teams.find_all {|game| game.team_id == id}
      if !team_games.empty?
        h[id] = average(team_games.map {|game| game.goals})
      else
        h[id] = nil
      end
    end
    worst_id = h.min_by do |_, value|
      if value != nil
        value
      else
        100
      end
    end[0]
    @teams.teams.find do |team|
      team.team_id == worst_id
    end.team_name
  end

  def highest_scoring_visitor
    # Name of the team with the highest average score per game across all seasons when they are away.

    # find team_id for each team
    team_ids = @teams.teams.map {|team| team.team_id}
    # game_teams_array = GameTeamsFactory.new
    # game_teams_array.create_game_teams("./fixture/game_teams_fixtures.csv")

    # for each game_team, find all away games with matching team_id
      # for each set of games, map goals
      # use average to return goals/game across all seasons
    # find team_id with highest gpg
    
    h = team_ids.each_with_object({}) do |id, h|
      away_games = @game_teams.game_teams.find_all {|game| game.team_id == id && game.hoa == "away"}
      if !away_games.empty?
        h[id] = average(away_games.map {|game| game.goals})
      else
        h[id] = nil
      end
    end
    best_id = h.max_by do |_, value|
      if value != nil
        value
      else
        0
      end
    end[0]
    @teams.teams.find do |team|
      team.team_id == best_id
    end.team_name
  end

  def highest_scoring_home_team
    # Name of the team with the highest average score per game across all seasons when they are home.

    # find team_id for each team
    team_ids = @teams.teams.map {|team| team.team_id}
    # game_teams_array = GameTeamsFactory.new
    # game_teams_array.create_game_teams("./fixture/game_teams_fixtures.csv")

    # for each game_team, find all home games with matching team_id
      # for each set of games, map goals
      # use average to return goals/game across all seasons
    # find team_id with highest gpg
    
    h = team_ids.each_with_object({}) do |id, h|
      home_games = @game_teams.game_teams.find_all {|game| game.team_id == id && game.hoa == "home"}
      if !home_games.empty?
        h[id] = average(home_games.map {|game| game.goals})
      else
        h[id] = nil
      end
    end
    best_id = h.max_by do |key, value|
      if value != nil
        value
      else
        0
      end
    end[0]
    @teams.teams.find do |team|
      team.team_id == best_id
    end.team_name
  end

  def lowest_scoring_visitor
    # Name of the team with the lowest average score per game across all seasons when they are away.

    # find team_id for each team
    team_ids = @teams.teams.map {|team| team.team_id}
    # game_teams_array = GameTeamsFactory.new
    # game_teams_array.create_game_teams("./fixture/game_teams_fixtures.csv")

    # for each game_team, find all away games with matching team_id
      # for each set of games, map goals
      # use average to return goals/game across all seasons
    # find team_id with lowest gpg
    
    h = team_ids.each_with_object({}) do |id, h|
      away_games = @game_teams.game_teams.find_all {|game| game.team_id == id && game.hoa == "away"}
      if !away_games.empty?
        h[id] = average(away_games.map {|game| game.goals})
      else
        h[id] = nil
      end
    end
    worst_id = h.min_by do |_, value|
      if value != nil
        value
      else
        100
      end
    end[0]
    @teams.teams.find do |team|
      team.team_id == worst_id
    end.team_name
  end

  def lowest_scoring_home_team
    # Name of the team with the lowest average score per game across all seasons when they are home.

    # find team_id for each team
    team_ids = @teams.teams.map {|team| team.team_id}
    # game_teams_array = GameTeamsFactory.new
    # game_teams_array.create_game_teams("./fixture/game_teams_fixtures.csv")

    # for each game_team, find all home games with matching team_id
      # for each set of games, map goals
      # use average to return goals/game across all seasons
    # find team_id with lowest gpg
    
    h = team_ids.each_with_object({}) do |id, h|
      home_games = @game_teams.game_teams.find_all {|game| game.team_id == id && game.hoa == "home"}
      if !home_games.empty?
        h[id] = average(home_games.map {|game| game.goals})
      else
        h[id] = nil
      end
    end
    worst_id = h.min_by do |_, value|
      if value != nil
        value
      else
        100
      end
    end[0]
    @teams.teams.find do |team|
      team.team_id == worst_id
    end.team_name
  end
end