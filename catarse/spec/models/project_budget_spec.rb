# == Schema Information
#
# Table name: project_budgets
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  name       :text             not null
#  value      :decimal(8, 2)    not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe ProjectBudget, :type => :model do
  describe "Associations" do
    it { is_expected.to belong_to(:project) }
  end

  describe "Validations" do
    it{ is_expected.to validate_presence_of(:name) }
    it{ is_expected.to validate_presence_of(:value) }
  end
end
