# == Schema Information
#
# Table name: credit_cards
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  last_digits     :text             not null
#  card_brand      :text             not null
#  subscription_id :text
#  created_at      :datetime
#  updated_at      :datetime
#  card_key        :text
#

require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe "Associations" do
    it{ is_expected.to belong_to :user }
  end

  describe "Validations" do
    it{ is_expected.to validate_presence_of(:user) }
    it{ is_expected.to validate_presence_of(:last_digits) }
    it{ is_expected.to validate_presence_of(:card_brand) }
  end
end
