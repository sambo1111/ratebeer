require 'rails_helper'

describe "Beers page" do

  describe "when creating one," do

    before :each do
      FactoryGirl.create :brewery, name:"Koff"
      FactoryGirl.create :user
      FactoryGirl.create :style
    end

    it "is saved if given correct name" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit new_beer_path
      fill_in("beer_name", with:"kalja")
      select("Koff", from:"beer_brewery_id")
      select("Lager", from:"beer_style_id")

      expect{
        click_button("Create Beer")
      }.to change{Beer.count}.from(0).to(1)
      expect(page).to have_content("Beer was successfully created.")
    end

    it "is not saved if given incorrect name" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit new_beer_path
      fill_in("beer_name", with:"")
      select("Koff", from:"beer_brewery_id")
      select("Lager", from:"beer_style_id")
      click_button("Create Beer")

      expect(Beer.count).to eq(0)
      expect(page).to have_content("Name is too short")
    end
  end
end
