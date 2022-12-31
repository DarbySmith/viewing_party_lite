require 'rails_helper'

RSpec.describe 'users dashboard page' do
  describe 'user is logged in' do  
    before :each do    
      @user_1 = create(:user)
      @user_2 = create(:user)
      @party_1 = create(:party)
      @party_2 = create(:party)
      @user_party_1 = UserParty.create!(user_id: @user_1.id, party_id: @party_1.id, host: true)
      @user_party_2 = UserParty.create!(user_id: @user_1.id, party_id: @party_2.id, host: false)

      visit root_path
      click_on "Log In"

      fill_in :username, with: @user_1.username
      fill_in :password, with: @user_1.password
      click_on "Log In"
    end
    
    it 'show the name of the user' do
      visit dashboard_path

      expect(page).to have_content("#{@user_1.name}'s Dashboard")
    end

    it 'has a button to discover movies' do
      visit dashboard_path

      expect(page).to have_button("Discover Movies")
      
      click_on "Discover Movies"

      expect(current_path).to eq("/users/#{@user_1.id}/discover")
    end

    it 'has a section that lists the viewing parties' do
      visit dashboard_path

      expect(page).to have_content("Viewing Parties")
      
      within("#party-#{@party_1.id}") do
        expect(page).to have_content(@party_1.day)
        expect(page).to have_content(@party_1.start_time)
        expect(page).to have_content(@party_1.movie_title)
        expect(page).to have_content("Hosting")
      end 
    end

    it 'has a section that lists the viewing parties' do
      visit dashboard_path

      expect(page).to have_content("Viewing Parties")
      
      within("#party-#{@party_2.id}") do
        expect(page).to have_content(@party_2.day)
        expect(page).to have_content(@party_2.start_time)
        expect(page).to have_content(@party_2.movie_title)
        expect(page).to have_content("Invited")
      end
    end
  end

  describe 'user is not logged in' do
    before :each do    
      @user_1 = create(:user)
      @user_2 = create(:user)
      @party_1 = create(:party)
      @party_2 = create(:party)
      @user_party_1 = UserParty.create!(user_id: @user_1.id, party_id: @party_1.id, host: true)
      @user_party_2 = UserParty.create!(user_id: @user_1.id, party_id: @party_2.id, host: false)
    end

    it 'returns an error when user tries to go to dashboard without being logged in' do
      visit dashboard_path

      expect(page).to have_content("User must be logged in or registered to access")
    end
  end
end