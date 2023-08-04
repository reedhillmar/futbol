require "spec_helper"

describe GameStats do
  before(:each) do
    @game1 = GameStats.new("./data/teams.csv", "./fixture/games_fixtures.csv", "./fixture/game_teams_fixtures.csv")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@game1).to be_a GameStats
      expect(@game1.teams).to be_a TeamsFactory
      expect(@game1.games).to be_a GamesFactory
      expect(@game1.game_teams).to be_a GameTeamsFactory
    end
  end

  describe '#highest_total_score' do 
    it 'returns a games highest total score' do 
      require 'pry'; binding.pry
      expect(@game1.highest_total_score).to eq(11)
    end
  end
end