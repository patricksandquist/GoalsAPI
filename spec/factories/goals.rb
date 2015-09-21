# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  body        :string
#  public_post :boolean          default(TRUE), not null
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    title { "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}"}
    body { "#{Faker::Hacker.say_something_smart}" }
    public_post { ['public', 'private'].sample }
    user_id 3
  end

end
