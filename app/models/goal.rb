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

class Goal < ActiveRecord::Base
  belongs_to :user

  validates :title, :user_id, presence: true
  validates :public_post, inclusion: { in: [true, false] }
end
