# coding: utf-8
# == Schema Information
#
# Table name: contribution_reports_for_project_owners
#
#  project_id         :integer
#  reward_id          :integer
#  project_owner_id   :integer
#  reward_description :text
#  deliver_at         :date
#  confirmed_at       :date
#  contribution_value :decimal(, )
#  service_fee        :decimal(, )
#  user_email         :text
#  cpf                :text
#  user_name          :text
#  payer_email        :text
#  gateway            :text
#  anonymous          :boolean
#  state              :text
#  street             :text
#  complement         :text
#  address_number     :text
#  neighbourhood      :text
#  city               :text
#  address_state      :text
#  zip_code           :text
#

require 'rails_helper'

RSpec.describe ContributionReportsForProjectOwner, type: :model do
  let(:project) { create(:project, state: 'online') }
  let(:reward) { create(:reward, project: project) }
  let(:project_2) { create(:project, state: 'online') }
  let(:reward_2) { create(:reward, project: project_2) }

  before do
    create(:confirmed_contribution, project: project)
    create(:confirmed_contribution, project: project, reward: reward)
    create(:pending_contribution, project: project, reward: reward)

    create(:confirmed_contribution, project: project_2)
    create(:pending_contribution, project: project_2, reward: reward_2)
    create(:confirmed_contribution, project: project_2, reward: reward_2)
  end

  describe "scopes" do
    subject { ContributionReportsForProjectOwner }

    it ".project_id" do
      expect(subject.project_id(project.id).count).to eq(3)
    end

    it ".reward_id" do
      expect(subject.reward_id(reward_2.id).count).to eq(2)
    end

    it ".project_owner_id" do
      expect(subject.project_owner_id(project.user.id).count).to eq(3)
    end

    it ".state('paid')" do
      expect(subject.state('paid').count).to eq(4)
    end

    it ".state('pending')" do
      expect(subject.state("pending").count).to eq(2)
    end
  end
end

