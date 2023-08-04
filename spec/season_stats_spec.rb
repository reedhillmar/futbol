require './lib/season_stats'
require './lib/game_teams_factory'
require './lib/games_factory'
require './lib/teams_factory'
require './lib/calculable'


RSpec.describe Season do
  describe '#initialize' do
    it "can initialize" do
      season = Season.new(20122013)
      expect(season).to be_a Season
    end
  end

  describe '#within_searched_season' do
    it "can return games within a season" do
      searched_season2 = Season.new(20122013)
      expect(searched_season2.within_searched_season).not_to eq nil
    end
  end

  describe '#most_tackles' do
    it "can return which team has the most tackles in a season" do
      searched_season = Season.new(20122013)
      expect(searched_season.most_tackles).to eq('Sporting Kansas City')
    end
  end

  describe '#least_tackles' do
    it "can return which team has the fewest tackles in a seasom" do
      searched_season = Season.new(20122013)
      expect(searched_season.fewest_tackles).to eq('FC Dallas')
    end
  end

  describe '#least_accurate_team' do
    it "can return which team had the lowest shot to goal percentage in a season" do
      searched_season = Season.new(20122013)
      expect(searched_season.least_accurate_team).to eq('Washington Spirit FC')
    end
  end

  describe '#most_accurate_team' do
    it "can return which team had the highest shot to goal percentage in a season" do
      searched_season = Season.new(20122013)
      expect(searched_season.most_accurate_team).to eq('Atlanta United')
    end
  end

  describe '#worst_coach' do
    it "can return the coach with the worst win loss percentage" do
    searched_season = Season.new(20122013)
    expect(searched_season.worst_coach).to eq('John Tortorella')
    end
  end

  describe '#winningest_coach' do
    it "can return the coach with the best win loss percentage" do
      searched_season = Season.new(20122013)
      expect(searched_season.winningest_coach).to eq('John Hynes')
    end
  end

  describe '#method_setup' do
    it 'can be used to setup the functionality of other methods' do
      searched_season = Season.new(20122013)
      expect(searched_season.method_setup).to include(GameTeamsFactory)
    end
  end
  


end