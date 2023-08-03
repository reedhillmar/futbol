#./lib/league.rb
require "./lib/calculable"

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
end