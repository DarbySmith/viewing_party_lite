require 'rails_helper'

RSpec.describe 'user logout' do
  before(:each) do
    user = create(:user)
    visit root_path

    click_on "Log In"

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"
    # allow_any_instance_of(ApplicationController)
    #   .to receive(:current_user)
    #   .and_return(user)
  end
  
  it 'has a log out button on the landing page' do
    visit root_path

    expect(page).to have_button("Log Out")
    expect(page).to_not have_button("Log In")
    expect(page).to_not have_button("Register as a User")
  end

  it 'log a user out when the button is clicked' do
    visit root_path

    expect(page).to have_button("Log Out")
    click_on "Log Out"

    expect(page).to have_button("Log In")
    expect(page).to have_button("Register as a User")
  end
end