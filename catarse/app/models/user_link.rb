# == Schema Information
#
# Table name: user_links
#
#  id         :integer          not null, primary key
#  link       :text             not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class UserLink < ActiveRecord::Base
  before_save :prepend_protocol
  belongs_to :user
  scope :with_link, ->{ where('link IS NOT NULL') }

  def without_protocol
    self.link.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end

  def hostname
    self.without_protocol.split('/')[0]
  end

  def prepend_protocol
    self.link = ('http://' + self.link) unless self.link[/^https?:\/\//]
  end

end
