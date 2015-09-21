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

feature "Editing Goals" do
  given(:goal) { create(:goal) }

  before(:each) do
    sign_up
    make_goal(goal.title, goal.body, goal.public_post)
  end

  scenario "Edits goal title" do
    visit goals_url
    click_link(goal.title)
    click_link("Edit")
    fill_in 'Title', with: "This is the edited title"
    click_button "Edit Goal"
    expect(page).to have_content("This is the edited title")
  end

  scenario "Edits goal body" do
    visit goals_url
    click_link(goal.title)
    click_link("Edit")
    fill_in 'Body', with: "This is the edited body"
    click_button "Edit Goal"
    expect(page).to have_content("This is the edited body")
  end

  scenario "Edits goal title on index page" do
    visit goals_url
    click_link(goal.title)
    click_link("Edit")
    fill_in 'Title', with: "This is the edited title"
    click_button "Edit Goal"
    visit goals_url
    expect(page).to have_content("This is the edited title")
  end

  scenario "Edits goal privacy" do
    sign_out
    sign_up
    make_goal("Privatize This", "", "public")
    visit goals_url
    click_link("Privatize This")
    click_link("Edit")
    choose('private')
    click_button "Edit Goal"
    sign_out
    sign_up
    expect(page).to_not have_content("Privatize This")
  end

  scenario "Does not update an untitled goal" do
    visit goals_url
    click_link(goal.title)
    click_link("Edit")
    fill_in 'Title', with: ""
    click_button "Edit Goal"
    expect(page).to have_content("Title can't be blank")
  end


end

feature "Deleting Goals" do
  given(:goal) { create(:goal) }

  before(:each) do
    sign_up
    make_goal(goal.title, goal.body, goal.public_post)
  end

  scenario "Deletes a goal" do
    visit goals_url
    click_link(goal.title)
    click_button("Delete")
    expect(page).to_not have_content(goal.title)
  end

  scenario "Cannot delete other's goal" do
    sign_out
    sign_up
    visit goals_url
    click_link(goal.title)
    expect(page).to_not have_content("Delete")
  end

end
