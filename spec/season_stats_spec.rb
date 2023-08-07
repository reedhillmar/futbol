require 'spec_helper'

RSpec.describe Season do
  before(:each) do
    @season = Season.new('./data/teams.csv', './fixture/games_fixtures.csv', './fixture/game_teams_fixtures.csv')
    @real_season = Season.new('./data/teams.csv', './data/games.csv', './data/game_teams.csv')
  end

  describe '#initialize' do
    it "can initialize" do
      expect(@season).to be_a Season
    end
  end

  describe '#within_searched_season' do
    it "can return games within a season" do
      expect(@season.within_searched_season('20122013')).not_to eq nil
    end
  end

  describe '#most_tackles' do
    it "can return which team has the most tackles in a season" do
      expect(@season.most_tackles('20122013')).to eq('Houston Dynamo')
    end

    it "can work for different seasons" do
      expect(@season.most_tackles('20162017')).to eq('Vancouver Whitecaps FC')
    end

    it "can work for a  larger database" do
      expect(@real_season.most_tackles('20122013')).to eq('FC Cincinnati')
    end
  end

  describe '#fewest_tackles' do
    it "can return which team has the fewest tackles in a seasom" do
      expect(@season.fewest_tackles('20122013')).to eq('Houston Dynamo')
    end

    it "can work for different seasons" do
      expect(@season.fewest_tackles('20162017')).to eq('Chicago Red Stars')
    end

    it "can work for a larger database" do
      expect(@real_season.fewest_tackles('20122013')).to eq('Atlanta United')
    end
  end

  describe '#least_accurate_team' do
    it "can return which team had the lowest shot to goal percentage in a season" do
      expect(@season.least_accurate_team('20122013')).to eq('Houston Dynamo')
    end

    it "can work for different seasons" do
      expect(@season.least_accurate_team('20162017')).to eq('Vancouver Whitecaps FC')
    end

    it "can work for a larger database" do
      expect(@real_season.least_accurate_team('20122013')).to eq('New York City FC')
    end
  end

  describe '#most_accurate_team' do
    it "can return which team had the highest shot to goal percentage in a season" do
      expect(@season.most_accurate_team('20122013')).to eq('Houston Dynamo')
    end
    it "can work for different seasons" do
      expect(@season.most_accurate_team('20162017')).to eq('Chicago Red Stars')
    end

    it "can work for a larger database" do
      expect(@real_season.most_accurate_team('20122013')).to eq('DC United')
    end
  end

  describe '#worst_coach' do
    it "can return the coach with the worst win loss percentage" do
      expect(@season.worst_coach('20122013')).to eq('John Tortorella')
    end

    it "can work for different seasons" do
      expect(@season.worst_coach('20162017')).to eq('Jared Bednar')
    end

    it "can work for a larger database" do
      expect(@real_season.worst_coach('20122013')).to eq('Martin Raymond')
    end
  end

  describe '#winningest_coach' do
    it "can return the coach with the best win loss percentage" do
      expect(@season.winningest_coach('20122013')).to eq('John Tortorella')
    end

    it "can work for different seasons" do
      expect(@season.winningest_coach('20162017')).to eq('Lindy Ruff')
    end

    it "can work for a larger database" do
      expect(@real_season.winningest_coach('20122013')).to eq('Dan Lacroix')
    end
  end

  describe '#method_setup' do
    it 'can be used to setup the functionality of other methods' do
      @season.within_searched_season('20122013')
      expect(@season.method_setup).not_to eq(nil)
    end
  end

  describe '#accumulating_game_results' do
    it 'can return the results of the results of team' do
      @season.within_searched_season('20122013')
      @season.method_setup
      expect(@season.accumulating_game_results).not_to eq(nil)
    end
  end

  describe '#calculate_team_shot_accuracy' do
    it 'can return the team accuracy of a team within a season' do
      @season.within_searched_season('20122013')
      @season.method_setup
      expect(@season.calculate_team_shot_accuracy).not_to eq(nil)
  end
end

  describe '#accumulating_tackles' do
    it 'can return the overall tackles of a team within a season' do
      @season.within_searched_season('20122013')
      @season.method_setup
      expect(@season.accumulating_tackles).not_to eq(nil)
    end
  end

  describe '#top_performer' do
    it 'can find the coach/team with the highest particular stat' do
      @season.within_searched_season('20122013')
      @season.method_setup
      @season.accumulating_game_results
      top_coach = @season.top_performer(@season.instance_variable_get(:@coach_win_percentages))
      expect(top_coach[0]).to be_a String
    end
  end

  describe '#worst_performer' do
    it 'can find the coach/team with the highest particular stat' do
      @season.within_searched_season('20122013')
      @season.method_setup
      @season.accumulating_game_results
      bottom_coach = @season.worst_performer(@season.instance_variable_get(:@coach_win_percentages))
      expect(bottom_coach[0]).to be_a String
    end
  end

    describe '#find_team_name' do
      it 'can find the team name associated with a team id' do
        @season.within_searched_season('20122013')
        @season.method_setup
        @season.accumulating_tackles
        bottom_team = @season.worst_performer(@season.instance_variable_get(:@team_tackles))
        expect(@season.find_team_name(bottom_team)).to be_a String
      end
    end
end