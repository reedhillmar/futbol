#./lib/league.rb
require "./lib/calculable"

class League
  include Calculable 

  attr_reader :teams

  def initialize
    @teams = []
  end
end