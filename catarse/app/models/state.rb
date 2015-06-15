# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  acronym    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class State < ActiveRecord::Base
  validates_presence_of :name, :acronym
  validates_uniqueness_of :name, :acronym

  def self.array
    @array ||= order(:name).pluck(:name, :acronym).push(['Outro / Other', 'outro / other'])
  end
end
