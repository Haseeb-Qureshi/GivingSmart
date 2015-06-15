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

class ProjectBudget < ActiveRecord::Base
  belongs_to :project

  validates :name, :value, presence: true
end
