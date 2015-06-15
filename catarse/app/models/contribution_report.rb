# == Schema Information
#
# Table name: contribution_reports
#
#  project_id            :integer
#  name                  :text
#  value                 :text
#  minimum_value         :text
#  description           :text
#  gateway               :text
#  acquirer_name         :json
#  acquirer_tid          :json
#  payment_method        :text
#  payment_service_fee   :text
#  key                   :text
#  created_at            :date
#  confirmed_at          :date
#  email                 :text
#  payer_email           :text
#  payer_name            :text
#  cpf                   :text
#  address_street        :text
#  address_complement    :text
#  address_number        :text
#  address_neighbourhood :text
#  address_city          :text
#  address_state         :text
#  address_zip_code      :text
#  state                 :text
#

class ContributionReport < ActiveRecord::Base
  attr_accessible :title, :body
  acts_as_copy_target
end
