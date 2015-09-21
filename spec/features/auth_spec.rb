require 'spec_helper'
require 'rails_helper'

feature "the Authentication process" do
  given(:user) { create(:user) }

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      click_button "Sign Up"
    end

    scenario "redirects to goal index page after signup" do
      expect(current_url).to eq(goals_url)
    end

    scenario "redirects to goal index page after signup" do
      expect(page).to have_content user.username
    end
  end

  feature "signing in a user" do
    before(:each) do
      visit new_session_url
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      click_button "Sign In"
    end

    scenario "redirects to goal index page after signin" do
      expect(current_url).to eq(goals_url)
    end

    scenario "redirects to goal index page after signin" do
      expect(page).to have_content user.username
    end
  end

  feature "sign out a user" do
    before(:each) do
      visit new_session_url
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      click_button "Sign In"
    end

    scenario "logout button present" do
      click_button "Sign Out"
      expect(current_url).to eq(new_session_url)
    end
  end

  feature "signed out state" do
    scenario "can't access private pages before signing in" do
      visit goals_url
      expect(current_url).to eq(new_session_url)
    end

    scenario "errors shown before signing in" do
      visit goals_url
      expect(page).to have_content("Please sign in or register!")
    end
  end

end
