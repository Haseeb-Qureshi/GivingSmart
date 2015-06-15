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

require 'rails_helper'

RSpec.describe CategoryFollower, :type => :model do
  describe "Associations" do
    before do
      create(:category_follower)
    end

    it{ is_expected.to belong_to :user }
    it{ is_expected.to belong_to :category }
  end
end
