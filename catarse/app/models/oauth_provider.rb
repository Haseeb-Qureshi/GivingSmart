# == Schema Information
#
# Table name: oauth_providers
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  key        :text             not null
#  secret     :text             not null
#  scope      :text
#  order      :integer
#  created_at :datetime
#  updated_at :datetime
#  strategy   :text
#  path       :text
#

class OauthProvider < ActiveRecord::Base
  # schema_associations was not working well here, 
  # maybe because we need this model during the application initialization
  # Not a big deal since we have only one association
  has_many :authorizations 
end
