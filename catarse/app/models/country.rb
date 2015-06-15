# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Country < ActiveRecord::Base
end
