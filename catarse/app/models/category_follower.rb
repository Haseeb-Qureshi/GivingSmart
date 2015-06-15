# == Schema Information
#
# Table name: category_followers
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class CategoryFollower < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates :category, uniqueness: { scope: :user }
end
