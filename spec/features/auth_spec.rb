require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  given(:user) { create(:user) }

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', :with => user.username
      fill_in 'password', :with => user.password
      click_button "Sign Up"
    end

    scenario "redirects to goal index page after signup" do
      expect(current_path).to eq(goals_url)
    end

    scenario "redirects to goal index page after signup" do
      expect(page).to have_content user.username
    end

  end

end
