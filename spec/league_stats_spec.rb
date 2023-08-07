require "spec_helper"

describe League do
  before(:each) do
    @league1 = League.new("./data/teams.csv", "./fixture/games_fixtures.csv", "./fixture/game_teams_fixtures.csv")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@league1).to be_a League
      expect(@league1.teams).to be_a TeamsFactory
      expect(@league1.game_teams).to be_a GameTeamsFactory
      expect(@league1.team_ids).to be_an Array
      expect(@league1.team_ids.empty?).to be false
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
      expect(@league1.highest_scoring_home_team).to eq("New England Revolution, New York City FC, New York Red Bulls, Portland Timbers, Chicago Red Stars")
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

  describe "#find_team_ids" do
    it "can return an array of team ids" do
      @league1.find_team_ids
      
      expect(@league1.team_ids[0]).to be 1
      expect(@league1.team_ids[5]).to be 3
      expect(@league1.team_ids[20]).to be 20
    end
  end

  describe "#average_goals" do
    it "can return a hash with average goals by team id" do
      expect(@league1.average_goals("total")).to be_a Hash 
      expect(@league1.average_goals("total")[8]).to be 3.0

      expect(@league1.average_goals("home")).to be_a Hash 
      expect(@league1.average_goals("home")[5]).to be 2.75

      expect(@league1.average_goals("away")).to be_a Hash 
      expect(@league1.average_goals("away")[3]).to be 2.0
    end
  end

  describe "#best_value" do
    it "can return the max value of a hash" do
      expect(@league1.best_value(@league1.average_goals("total"))).to be 4.0
    end
  end

  describe "#worst_value" do
    it "can return the min value of a hash" do
      expect(@league1.worst_value(@league1.average_goals("total"))).to be 0.0
    end
  end

  describe "#best_ids" do
    it "can return an array of team ids that have the max value of a hash" do
      expect(@league1.best_ids(@league1.average_goals("total"))).to be_an Array
      expect(@league1.best_ids(@league1.average_goals("total"))[0]).to be 1
    end
  end

  describe "#worst_ids" do
    it "can return an array of team ids that have the min value of a hash" do
      expect(@league1.worst_ids(@league1.average_goals("total"))).to be_an Array
      expect(@league1.worst_ids(@league1.average_goals("total"))[0]).to be 22
    end
  end

  describe "#best_teams" do
    it "can return a string of the best teams according to a given criteria" do
      expect(@league1.best_teams(@league1.average_goals("total"))).to be_a String
      expect(@league1.best_teams(@league1.average_goals("total"))).to eq("Atlanta United")
    end
  end

  describe "#worst_teams" do
    it "can return a string of the worst teams according to a given criteria" do
      expect(@league1.worst_teams(@league1.average_goals("total"))).to be_a String
      expect(@league1.worst_teams(@league1.average_goals("total"))).to eq("Washington Spirit FC")
    end
  end
end
