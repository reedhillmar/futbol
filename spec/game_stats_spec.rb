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
      expect(@game1.highest_total_score).to eq(7)
    end
  end

  describe '#lowest_total_score' do 
    it 'returns a games lowest total score' do 
      expect(@game1.lowest_total_score).to eq(1)
    end
  end

  describe '#percentage_home_wins' do 
    it 'returns the percentage of home wins' do 
      expect(@game1.percentage_home_wins).to eq(45.45)
    end
  end

  describe '#percentage_visitor_wins' do 
    it 'returns the percentage of visitor wins' do 
      expect(@game1.percentage_visitor_wins).to eq(36.36)
    end
  end

  describe '#percentage_ties' do 
    it 'returns the percentage of ties' do 
      expect(@game1.percentage_ties).to eq(0.18)
    end
  end  
  
    describe '#average_goals_per_game' do 
      it 'returns the average number of goals per game' do 
        expect(@game1.average_goals_per_game).to eq(0.18)
    end
  end

end