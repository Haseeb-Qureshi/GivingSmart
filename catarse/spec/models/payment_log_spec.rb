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

require 'rails_helper'

RSpec.describe PaymentLog, type: :model do
  describe "Validations" do
    it{ is_expected.to validate_presence_of(:gateway_id) }
    it{ is_expected.to validate_presence_of(:data) }
  end
end
