require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    @user = FactoryGirl.create :user
  end

  describe "any client" do
    it "can see user's favorite style correctly" do
      beer = FactoryGirl.create(:beer, name: "Kaljonki", style: "Lager")
      beer2 = FactoryGirl.create(:beer, name: "Ei kaljonki", style: "Not Lager")
      FactoryGirl.create(:rating, score:30, beer:beer, user:@user)
      FactoryGirl.create(:rating, score:40, beer:beer, user:@user)
      FactoryGirl.create(:rating, score:30, beer:beer2, user:@user)

      visit user_path(@user)
      expect(page).to have_content('favorite style: Lager')

    end

      it "can see user's favorite brewery correctly" do
        brewery = FactoryGirl.create(:brewery, name: "Paras")
        brewery2 = FactoryGirl.create(:brewery, name: "Huono")
        beer = FactoryGirl.create(:beer, name: "Kaljonki", brewery:brewery, style: "Lager")
        beer2 = FactoryGirl.create(:beer, name: "Ei kaljonki", brewery:brewery2, style: "Not Lager")
        FactoryGirl.create(:rating, score:30, beer:beer, user:@user)
        FactoryGirl.create(:rating, score:40, beer:beer, user:@user)
        FactoryGirl.create(:rating, score:30, beer:beer2, user:@user)

        visit user_path(@user)
        expect(page).to have_content('favorite brewery: Paras')

      end
  end

  describe "who has signed up" do
    it "can signin with right credidentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content('Welcome back')
      expect(page).to have_content('Pekka')
    end
    it "is redirected back to signin if wrong credidentials" do
      sign_in(username:"Pekka", password:"shit")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content('Invalid username or password!')
    end
    it "has his own, but not other users', ratings shown on his userpage" do
      user = FactoryGirl.create :user, username:"datboi"
      FactoryGirl.create :rating_with_beer, user:user

      beer = FactoryGirl.create :beer, name:"Kalja"
      rating = FactoryGirl.create :rating, score:20, beer:beer, user:@user

      visit user_path(@user)
      expect(page).to have_content("#{rating.beer.name} [#{rating.score}]")
      expect(page).to have_content("has made 1 rating")
      expect(page).not_to have_content("anonymous [15]")

    end
    it "and deletes a rating destroys the rating by doing so" do
      sign_in(username:"Pekka", password:"Foobar1")

      beer = FactoryGirl.create :beer, name:"Kalja"
      rating = FactoryGirl.create :rating, score:20, beer:beer, user:@user

      visit user_path(@user)

      expect(page).to have_content("delete")
      expect{
        click_link("delete")
      }.to change{Rating.count}.from(1).to(0)

      expect(page).not_to have_content("#{rating.beer.name} [#{rating.score}]")
    end
  end

  describe "who has not signed up" do
    it "is added to the system when signing up" do
      visit signup_path
      fill_in('user_username', with:'datboi')
      fill_in('user_password', with:'Wadup1')
      fill_in('user_password_confirmation', with:'Wadup1')

      expect {
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end
end
