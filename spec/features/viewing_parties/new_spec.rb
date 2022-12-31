require 'rails_helper'

RSpec.describe 'new viewing party page' do
  describe 'user is logged into application' do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)

      visit root_path

      click_on "Log In"

      fill_in :username, with: @user_1.username
      fill_in :password, with: @user_1.password
      click_on "Log In"
    end

    it 'should fields for party duration, when, start time, check boxes with existing users', :vcr do
      visit new_movie_viewing_party_path(238)

      expect(page).to have_content("The Godfather")
      expect(page).to have_field(:duration)
      expect(page).to have_field(:day)
      expect(page).to have_field(:start_time)
      expect(page).to_not have_content(@user_1.name)
      expect(page).to have_content(@user_2.name)
    end

    it 'can create new parties', :vcr do
      visit new_movie_viewing_party_path(238)

      fill_in :duration, with: 175
      fill_in :day, with: "2022-12-14"
      fill_in :start_time, with: "2000-01-01 16:37:00 UTC"
      check("attendees_#{@user_2.id}")
      check("attendees_#{@user_3.id}")

      click_on "Create Party"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Godfather")
      expect(page).to have_content("2022-12-14")
      expect(page).to have_content("2000-01-01 16:37:00 UTC")
      expect(page).to have_content("Hosting")
    end

    it 'cannot make a party with missing attributes', :vcr do
      visit new_movie_viewing_party_path(238)
      
      fill_in :duration, with: 175
      fill_in :day, with: ""
      fill_in :start_time, with: Time.parse("18:00")
      check("attendees_#{@user_2.id}")
      check("attendees_#{@user_3.id}")
      click_on "Create Party"

      expect(page).to have_content("Day can't be blank")
    end

    it 'cannot make a party with missing attributes', :vcr do
      visit new_movie_viewing_party_path(238)
      
      fill_in :duration, with: 175
      fill_in :day, with: Date.today
      fill_in :start_time, with: ""
      check("attendees_#{@user_2.id}")
      check("attendees_#{@user_3.id}")

      click_on "Create Party"

      expect(page).to have_content("Start time can't be blank")
    end
  end

  describe 'user is not logged into application' do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)
    end

    it 'displays an error message if a user tries to create a party', :vcr do
      visit '/movies/238'

      click_on "Create Viewing Party for The Godfather"

      expect(current_path).to eq("/movies/238")
      expect(page).to have_content("User must be logged in or registered to access")
    end
  end
end