require './lib/season_stats'
require './lib/game_teams_factory'
require './lib/games_factory'
require './lib/teams_factory'
require './lib/calculable'


RSpec.describe Season do
  before(:each) do
    @season = Season.new(20122013, './data/teams.csv', './fixture/games_fixtures.csv', './fixture/game_teams_fixtures.csv')
    @alt_season = Season.new(20162017, './data/teams.csv', './fixture/games_fixtures.csv', './fixture/game_teams_fixtures.csv')
    # @real_season = Season.new(20122013, './data/teams.csv', './data/games.csv', './data/game_teams.csv')
  end

  describe '#initialize' do
    it "can initialize" do
      expect(@alt_season).to be_a Season
    end
  end

  describe '#within_searched_season' do
    it "can return games within a season" do
      expect(@season.within_searched_season).not_to eq nil
    end
  end

  describe '#most_tackles' do
    it "can return which team has the most tackles in a season" do
      expect(@season.most_tackles).to eq('Houston Dynamo')
    end

    it "can work for different seasons" do
      expect(@alt_season.most_tackles).to eq('Vancouver Whitecaps FC')
    end

    xit "can work for a  larger database" do
      expect(@real_season.most_tackles).to eq('FC Cincinnati')
    end
  end

  describe '#fewest_tackles' do
    it "can return which team has the fewest tackles in a seasom" do
      expect(@season.fewest_tackles).to eq('Houston Dynamo')
    end

    it "can work for different seasons" do
      expect(@alt_season.fewest_tackles).to eq('Chicago Red Stars')
    end

    xit "can work for a larger database" do
      expect(@real_season.fewest_tackles).to eq('Atlanta United')
    end
  end

  describe '#least_accurate_team' do
    it "can return which team had the lowest shot to goal percentage in a season" do
      expect(@season.least_accurate_team).to eq('Houston Dynamo')
    end

    it "can work for different seasons" do
      expect(@alt_season.least_accurate_team).to eq('Vancouver Whitecaps FC')
    end

    xit "can work for a larger database" do
      expect(@real_season.least_accurate_team).to eq('New York City FC')
    end
  end

  describe '#most_accurate_team' do
    it "can return which team had the highest shot to goal percentage in a season" do
      expect(@season.most_accurate_team).to eq('Houston Dynamo')
    end
    it "can work for different seasons" do
      expect(@alt_season.most_accurate_team).to eq('Chicago Red Stars')
    end

    xit "can work for a larger database" do
      expect(@real_season.most_accurate_team).to eq('DC United')
    end
  end

  describe '#worst_coach' do
    it "can return the coach with the worst win loss percentage" do
    expect(@season.worst_coach).to eq('John Tortorella')
    end
    it "can work for different seasons" do
      expect(@alt_season.worst_coach).to eq('Joe Sacco')
    end

    xit "can work for a larger database" do
      expect(@real_season.worst_coach).to eq('Gerard Gallant')
    end
  end

  describe '#winningest_coach' do
    it "can return the coach with the best win loss percentage" do
      expect(@season.winningest_coach).to eq('John Tortorella')
    end
    it "can work for different seasons" do
      expect(@alt_season.winningest_coach).to eq('Ken Hitchcock')
    end

    xit "can work for a larger database" do
      expect(@real_season.winningest_coach).to eq('Claude Julien')
    end
  end

  describe '#method_setup' do
    it 'can be used to setup the functionality of other methods' do
      expect(@season.method_setup).not_to eq(nil)
    end
  end
  


end