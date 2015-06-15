# == Schema Information
#
# Table name: bank_accounts
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  account        :text             not null
#  agency         :text             not null
#  owner_name     :text             not null
#  owner_document :text             not null
#  created_at     :datetime
#  updated_at     :datetime
#  account_digit  :text             not null
#  agency_digit   :text
#  bank_id        :integer          not null
#

require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe "associations" do
    it{ is_expected.to belong_to :user }
  end

  describe "Validations" do
    it{ is_expected.to validate_presence_of(:bank_id) }
    it{ is_expected.to validate_presence_of(:agency) }
    it{ is_expected.to validate_presence_of(:account) }
    it{ is_expected.to validate_presence_of(:account_digit) }
    it{ is_expected.to validate_presence_of(:owner_name) }
    it{ is_expected.to validate_presence_of(:owner_document) }
  end
end
