require 'capybara/rspec'

RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

end

def sign_up
  username = Faker::Internet.user_name
  password = Faker::Internet.password
  visit "/users/new"
  fill_in "Username", with: username
  fill_in "Password", with: password
  click_button 'Sign Up'
end

def sign_in
  username = Faker::Internet.user_name
  password = Faker::Internet.password
  visit "/session/new"
  fill_in "Username", with: username
  fill_in "Password", with: password
  click_button 'Sign In'
end

def make_goal(title = nil, body = nil, public_post = nil)
  title ||=  "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}"
  body ||=  "#{Faker::Hacker.say_something_smart}"
  public_post ||= ["public", "private"].sample
  visit "/goals/new"
  fill_in 'Title', with: title
  fill_in 'Body', with: body
  choose(public_post)
  click_button "Create New Goal"
end

def sign_out
  click_button "Sign Out"
end
