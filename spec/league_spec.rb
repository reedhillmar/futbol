require "spec_helper"

describe League do
  before(:each) do
    @league1 = League.new
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@league1).to be_a League
      expect(@league1.teams).to eq([])
    end
  end
end