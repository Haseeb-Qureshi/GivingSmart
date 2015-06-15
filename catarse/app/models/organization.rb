# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  email       :string(255)      not null
#  website_url :string(255)
#  phone       :string(255)
#  address     :text
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Organization < ActiveRecord::Base
  has_many :organization_admins
  has_many :admins, through: :organization_admins, source: :user
end
