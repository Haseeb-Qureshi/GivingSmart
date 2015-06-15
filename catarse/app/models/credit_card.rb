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

class CreditCard < ActiveRecord::Base
  belongs_to :user

  validates :user, :last_digits, :card_brand, presence: true

  def decorator
    CreditCardDecorator.new(self)
  end

  def display_digits
    "XXXX-XXXX-XXXX-#{last_digits}"
  end
end
