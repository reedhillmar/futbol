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
end