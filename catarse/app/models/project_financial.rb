# == Schema Information
#
# Table name: project_financials
#
#  project_id          :integer
#  name                :text
#  moip                :string(255)
#  goal                :decimal(, )
#  reached             :decimal(, )
#  payment_tax         :decimal(, )
#  catarse_fee         :decimal(, )
#  repass_value        :decimal(, )
#  expires_at          :text
#  contribution_report :text
#  state               :string(255)
#

class ProjectFinancial < ActiveRecord::Base
  acts_as_copy_target
end
