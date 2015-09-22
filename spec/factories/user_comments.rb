# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  user_id    :integer
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user_comment do
    body { "#{Faker::Hacker.say_something_smart}" }
    author_id 4
    user_id 3
  end


end
