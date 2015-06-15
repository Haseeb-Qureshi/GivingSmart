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

class BankAccount < ActiveRecord::Base
  include CatarsePagarme::BankAccountConcern

  belongs_to :user
  belongs_to :bank

  validates :bank_id, :agency, :account, :owner_name, :owner_document, :account_digit, presence: true

  def bank_code
    self.bank.code
  end
end
