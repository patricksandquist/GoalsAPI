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
    title "MyString"
body "MyString"
public_post false
user nil
  end

end
