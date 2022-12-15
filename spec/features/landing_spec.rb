require 'rails_helper'

RSpec.describe 'root path; application landing page' do
  describe 'A user is logged in' do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)

      visit root_path

      click_on "Log In"

      fill_in :username, with: @user_1.username
      fill_in :password, with: @user_1.password
      click_on "Log In"
    end
    
    it 'has the title of the application and existing users' do
      visit root_path

      expect(page).to have_content("Viewing Party Lite")
      expect(page).to have_content(@user_1.email)
      expect(page).to have_content(@user_2.email)
    end

    it 'has a button to visit the dashboard' do
      visit root_path

      expect(page).to have_button("My Dashboard")
      click_on "My Dashboard"

      expect(current_path).to eq(user_path(@user_1))
    end
  end

  describe 'no user is logged in' do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)
    end
    
    it 'has a button to create a new user' do
      visit root_path
  
      expect(page).to have_button("Register as a User")
      
      click_on "Register as a User"
  
      expect(current_path).to eq(new_user_path)
    end
  
    it 'has a link to visit the landing page' do
      visit root_path
  
      expect(page).to have_link("Home")
  
      click_on "Home"
  
      expect(current_path).to eq('/')
    end
  
    it 'has a link to log in' do
      visit root_path
  
      expect(page).to have_button("Log In")
      click_on "Log In"
  
      expect(current_path).to eq("/login")
    end
  
    it 'does not show the registered users if not logged in' do
      visit root_path
      
      expect(page).to_not have_content(@user_1.name)
      expect(page).to_not have_content(@user_2.name)
    end
  end
end