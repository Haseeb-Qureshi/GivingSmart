# == Schema Information
#
# Table name: project_financials
#
#  project_id          :integer
#  name                :text
#  moip                :string(255)
#  goal                :decimal(, )
#  reached             :decimal(, )
#  payment_tax         :decimal(, )
#  catarse_fee         :decimal(, )
#  repass_value        :decimal(, )
#  expires_at          :text
#  contribution_report :text
#  state               :string(255)
#

require 'rails_helper'

RSpec.describe ProjectFinancial, type: :model do
  let(:project) { create(:project, state: 'online') }

  subject{ ProjectFinancial.where(project_id: project.id).first }

  before do
    CatarseSettings[:base_url] = 'localhost'
    CatarseSettings[:catarse_fee] = 0.13
    create_contribution_with_payment(project.id, 'pending')
    create_contribution_with_payment(project.id, 'paid')
    create_contribution_with_payment(project.id, 'refunded')
    create_contribution_with_payment(project.id, 'pending_refund')
  end

  describe "#name" do
    it{ expect(subject.name).to eq(project.name) }
  end

  describe "#goal" do
    it{ expect(subject.goal).to eq(project.goal) }
  end

  describe "#reached" do
    it{ expect(subject.reached).to eq(project.pledged) }
  end
end

