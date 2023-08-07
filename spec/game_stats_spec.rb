require "spec_helper"

describe GameStats do
  before(:each) do
    @game1 = GameStats.new("./data/teams.csv", "./fixture/games_fixtures.csv", "./fixture/game_teams_fixtures.csv")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@game1).to be_a GameStats
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
      expect(@game1.percentage_home_wins).to eq(0.45)
    end
  end

  describe '#percentage_visitor_wins' do 
    it 'returns the percentage of visitor wins' do 
      expect(@game1.percentage_visitor_wins).to eq(0.36)
    end
  end

  describe '#percentage_ties' do 
    it 'returns the percentage of ties' do 
      expect(@game1.percentage_ties).to eq(0.18)
    end
  end  
  
  describe '#average_goals_per_game' do 
    it 'returns the average number of goals per game' do 
      expect(@game1.average_goals_per_game).to eq(3.84)
    end
  end

  describe '#count_of_games_by_season' do 
    it 'returns a hash of number of games by season' do 
      expected = {
        "20122013"=>8, "20132014"=>13, "20152016"=>8, 
        "20162017"=>3, "20172018"=>3, "20142015"=>9
      }

      expect(@game1.count_of_games_by_season).to eq(expected)
    end
  end

  describe '#average_goals_by_season' do 
    it 'returns a hash of average number of goals by season' do 
      expected = {
        "20122013"=>4.25, "20132014"=>3.92, "20152016"=>4.0, 
        "20162017"=>3.67, "20172018"=>4.33, "20142015"=>3.11
      }
      
      expect(@game1.average_goals_by_season).to eq(expected)
    end
  end
end