require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "is saved" do
    it "if it has a name and a date set" do
      style = FactoryGirl.create :style
      beer = Beer.create name:"testbeer", style:style
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  describe "is not saved" do
    it "if it has no name" do
      style = FactoryGirl.create :style
      beer = Beer.create style:style
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "if it has no style" do
      beer = Beer.create name:"testzz"
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
