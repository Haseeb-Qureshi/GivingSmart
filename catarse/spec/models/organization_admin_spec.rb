# == Schema Information
#
# Table name: organization_admins
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  organization_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe OrganizationAdmin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
