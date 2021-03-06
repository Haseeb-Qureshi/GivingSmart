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

require 'rails_helper'

RSpec.describe ProjectsForHome, type: :model do
  describe "association" do
    it{ is_expected.to have_one :project_total } 
  end
  describe '.recommends' do
    before do
      4.times { create(:project, recommended: true, state: 'online') }
      @not_recommended_01 = create(:project, recommended: false, state: 'online')
    end

    subject { ProjectsForHome.recommends }

    it { is_expected.to have(3).itens }
    it { is_expected.not_to include(@not_recommended_01) }
  end

  describe '.recents' do
    before do
      4.times { create(:project, recommended: false, state: 'online', online_date: 4.days.ago ) }
      @not_recents_01 = create(:project, state: 'online', online_date: 6.days.ago)
    end

    subject { ProjectsForHome.recents }

    it { is_expected.to have(3).itens }
    it { is_expected.not_to include(@not_recents_01) }
  end

  describe '.expiring' do
    before do
      4.times { create(:project, recommended: false, state: 'online', online_days: 10, online_date: 6.days.ago ) }
      @not_expiring_01 = create(:project, recommended: false, state: 'online', online_days: 50, online_date: 2.days.ago)
    end

    subject { ProjectsForHome.expiring }

    it { is_expected.to have(3).itens }
    it { is_expected.not_to include(@not_expiring_01) }
  end

  describe "to_partial_path" do
    subject{ ProjectsForHome.new.to_partial_path }
    it{ is_expected.to eq('projects/project') }
  end
end
