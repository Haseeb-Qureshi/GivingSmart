# == Schema Information
#
# Table name: project_accounts
#
#  id                    :integer          not null, primary key
#  project_id            :integer          not null
#  bank_id               :integer
#  email                 :text             not null
#  state_inscription     :text
#  address_street        :text             not null
#  address_number        :text             not null
#  address_complement    :text
#  address_city          :text             not null
#  address_neighbourhood :text             not null
#  address_state         :text             not null
#  address_zip_code      :text             not null
#  phone_number          :text             not null
#  agency                :text             not null
#  agency_digit          :text             not null
#  account               :text             not null
#  account_digit         :text             not null
#  owner_name            :text             not null
#  owner_document        :text             not null
#  created_at            :datetime
#  updated_at            :datetime
#  account_type          :text
#

class ProjectAccount < ActiveRecord::Base
  belongs_to :project
  belongs_to :bank

  validates_presence_of :email, :address_street, :address_number, :address_city, :address_state, :address_zip_code, :phone_number, :bank, :agency, :account, :account_digit, :owner_name, :owner_document, :account_type

  def entity_type
    if owner_document
      owner_document.length > 14 ? 'Pessoa Jurídica' : 'Pessoa Física'
    else
      'Pessoa Física'
    end
  end

end
