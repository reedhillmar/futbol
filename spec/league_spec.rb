require "spec_helper"

describe League do
  before(:each) do
    @league1 = League.new
    @team1 = double("team1")
    @team2 = double("team2")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@league1).to be_a League
      expect(@league1.teams).to eq([])
    end
  end

  describe "#add_team" do
    it "can add teams" do
      @league1.add_team(@team1)
      @league1.add_team(@team2)

      expect(@league1.teams).to eq([@team1, @team2])
    end
  end

  describe "#count_of_teams" do
    it "can return the number of teams" do
      @league1.add_team(@team1)
      @league1.add_team(@team2)

      expect(@league1.count_of_teams).to be 2
    end
  end

  describe "#best_offense" do
    it "can return the team with the highest average goals per game across all seasons" do
      @league1.add_team(@team1)
      @league1.add_team(@team2)

      expect(@league1.best_offense).to eq(@team2.team_name)
    end
  end
end