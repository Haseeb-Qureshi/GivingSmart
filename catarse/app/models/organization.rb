class Organization < ActiveRecord::Base
  has_many :organization_admins
  has_many :admins, through: :organization_admins, source: :user
end
