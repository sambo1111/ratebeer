require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [Place.new(name:"Oljenkorsi", id: 1)]
    )

    visit places_path
    fill_in('city', with:'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple are returned by the API, they are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("haaga").and_return(
    [Place.new(name:"Lemon", id: 1), Place.new(name:"Lau", id: 2)]
    )

    visit places_path
    fill_in('city', with:'haaga')
    click_button "Search"

    expect(page).to have_content "Lemon"
    expect(page).to have_content "Lau"

  end

  it "if none are returned by the API, display notification for not found" do
    allow(BeermappingApi).to receive(:places_in).with("turku").and_return(
    []
    )

    visit places_path
    fill_in('city', with:'turku')
    click_button 'Search'

    expect(page).to have_content "No locations in turku"
  end
end
