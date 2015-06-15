# == Schema Information
#
# Table name: payment_logs
#
#  id         :integer          not null, primary key
#  gateway_id :string(255)      not null
#  data       :json             not null
#  created_at :datetime
#  updated_at :datetime
#

class PaymentLog < ActiveRecord::Base
  validates :gateway_id, :data, presence: true
end
