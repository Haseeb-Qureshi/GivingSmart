# == Schema Information
#
# Table name: project_totals
#
#  project_id                :integer
#  pledged                   :decimal(, )
#  progress                  :decimal(, )
#  total_payment_service_fee :decimal(, )
#  total_contributions       :integer
#

class ProjectTotal < ActiveRecord::Base
end
