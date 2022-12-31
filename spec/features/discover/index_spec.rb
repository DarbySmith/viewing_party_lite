require 'rails_helper'

RSpec.describe 'user discover movies page' do
  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)

    visit root_path

    click_on "Log In"

    fill_in :username, with: @user_1.username
    fill_in :password, with: @user_1.password
    click_on "Log In"
  end
  
  it 'has a button to discover top rated movies', :vcr do
    visit discover_path

    expect(page).to have_button("Find Top Rated Movies")

    click_on "Find Top Rated Movies"

    expect(current_path).to eq("/users/#{@user_1.id}/movies")
  end

  it 'has a text field to enter keywords and button to search by movie title', :vcr do
    visit discover_path

    expect(page).to have_field(:search)
    expect(page).to have_button("Find Movies")
    
    fill_in :search, with: "Nemo"
    click_on "Find Movies"

    expect(current_path).to eq("/users/#{@user_1.id}/movies")
  end
end