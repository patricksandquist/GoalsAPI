require 'spec_helper'
require 'rails_helper'



feature "Creating goals" do
  given(:goal) { create(:goal) }

  scenario "has a new goal page" do
    sign_up
    visit new_goal_url
    expect(page).to have_content "New goal"
  end

  scenario "makes new goal and redirects to show page" do
    sign_up
    make_goal(goal.title, goal.body, goal.public_post)
    expect(page).to have_content(goal.title)
  end

  scenario "makes new goal and is on index page" do
    sign_up
    make_goal(goal.title, goal.body, goal.public_post)
    visit goals_url
    expect(page).to have_content(goal.title)
  end

  scenario "other users can't see a private post" do
    sign_up
    make_goal(goal.title, goal.body, "private")
    sign_out
    sign_up
    expect(page).to_not have_content(goal.title)
  end

  scenario "doesn't make blank title goal" do
    sign_up
    visit "/goals/new"
    fill_in 'Title', with: nil
    choose("public")
    click_button "Create New Goal"
    expect(page).to have_content("Title can't be blank")
  end

end

#able to make / create goals
  # Have to specify title
  # Direct to show page
  # Visit index page

#editting goals
  # change the tile
  #change the body
  # public_post
  # If there are public goals can delete your own

#destroy goals
  #deleted from Index page
  # can only delete your own goals
  # If there are public goals can delete your own
