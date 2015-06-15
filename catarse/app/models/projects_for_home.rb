# == Schema Information
#
# Table name: projects_for_home
#
#  origin            :text
#  id                :integer          primary key
#  name              :text
#  expires_at        :datetime
#  user_id           :integer
#  category_id       :integer
#  goal              :decimal(, )
#  headline          :text
#  video_url         :text
#  short_url         :text
#  created_at        :datetime
#  updated_at        :datetime
#  about_html        :text
#  recommended       :boolean
#  home_page_comment :text
#  permalink         :text
#  video_thumbnail   :text
#  state             :string(255)
#  online_days       :integer
#  online_date       :datetime
#  traffic_sources   :text
#  more_links        :text
#  first_backers     :text
#  uploaded_image    :string(255)
#  video_embed_url   :string(255)
#

class ProjectsForHome < Project
  self.table_name = 'projects_for_home'
  has_one :project_total, foreign_key: :project_id

  scope :recommends, -> { where(origin: 'recommended') }
  scope :recents, -> { where(origin: 'recents') }
  scope :expiring, -> { where(origin: 'expiring') }

  def to_partial_path
    "projects/project"
  end
end
