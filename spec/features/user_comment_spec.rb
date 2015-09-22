require 'spec_helper'
require 'rails_helper'

feature "Creating comments" do
  given(:user_comment) { create(:user_comment) }

  before(:each) do
    sign_up("bob", "bobbob")
    click_link("bob")
  end

  scenario "comment on a own page" do
    fill_in 'Comment', with: user_comment.body
    click_button("Comment")
    expect(page).to have_content(user_comment.body)
  end

  scenario "delete own page" do
    fill_in 'Comment', with: user_comment.body
    click_button("Comment")
    click_button("Delete")
    expect(page).to_not have_content(user_comment.body)
  end
end
