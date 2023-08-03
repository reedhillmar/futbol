require "spec_helper"

describe League do
  before(:each) do
    @league1 = League.new("./data/teams.csv", "./fixture/games_fixtures.csv", "./fixture/game_teams_fixtures.csv")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@league1).to be_a League
      expect(@league1.teams).to be_a TeamsFactory
      expect(@league1.games).to be_a GamesFactory
      expect(@league1.game_teams).to be_a GameTeamsFactory
    end
  end

  describe "#count_of_teams" do
    it "can return the number of teams" do

      expect(@league1.count_of_teams).to be 32
    end
  end

  describe "#best_offense" do
    it "can return the team with the highest average goals per game across all seasons" do
      expect(@league1.best_offense).to eq("Atlanta United")
    end
  end

  describe "#worst_offense" do
    it "can return the team with the lowest average goals per game across all seasons" do
      expect(@league1.worst_offense).to eq("Washington Spirit FC")
    end
  end

  describe "#highest_scoring_visitor" do
    it "can return the team with the highest average goals per game while away across all seasons" do
      expect(@league1.highest_scoring_visitor).to eq("Atlanta United")
    end
  end

  describe "#highest_scoring_home_team" do
    it "can return the team with the highest average goals per game while home across all seasons" do
      expect(@league1.highest_scoring_home_team).to eq("New England Revolution")
    end
  end

  describe "#lowest_scoring_visitor" do
    it "can return the team with the lowest average goals per game while away across all seasons" do
      expect(@league1.lowest_scoring_visitor).to eq("FC Dallas, Orlando City SC, Toronto FC, Orlando Pride")
    end
  end

  describe "#lowest_scoring_home_team" do
    it "can return the team with the lowest average goals per game while home across all seasons" do
      expect(@league1.lowest_scoring_home_team).to eq("Washington Spirit FC")
    end
  end
end