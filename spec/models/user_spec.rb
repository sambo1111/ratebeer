require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"
    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user)}

    it "has a method for determining the favorite_beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 20)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_rating(user, 10, 11, 24, 22, 1)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "without a proper password" do
    it "is not saved if the password is too short" do
      user = User.create username:"Goliath", password:"A1", password_confirmation:"A1"
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "is not saved if the password has only alphabets" do
      user = User.create username:"Daavid", password:"Qwerty", password_confirmation:"Qwerty"
    end
  end

  describe "with a proper password" do
    let(:user){FactoryGirl.create(:user)}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average" do

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_rating(user, *scores)
    scores.each do |score|
      create_beer_with_rating(user, score)
    end
  end
end
