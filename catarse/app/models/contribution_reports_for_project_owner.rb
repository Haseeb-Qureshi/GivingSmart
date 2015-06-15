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

class ContributionReportsForProjectOwner < ActiveRecord::Base
  acts_as_copy_target

  scope :project_id, -> (project_id) { where(project_id: project_id) }
  scope :reward_id, -> (reward_id) { where(reward_id: reward_id) }
  scope :state, -> (state) { where(state: state) }
  scope :project_owner_id, -> (project_owner_id) { where(project_owner_id: project_owner_id) }

  def self.report
    report_sql = ""
    I18n.t('contribution_report_to_project_owner').keys[0..-2].each{
      |column| report_sql << "#{column} AS \"#{I18n.t("contribution_report_to_project_owner.#{column}")}\","
    }

    self.select(%Q{
        #{report_sql}
        CASE WHEN anonymous='t' THEN '#{I18n.t('yes')}'
            WHEN anonymous='f' THEN '#{I18n.t('no')}'
        END as "#{I18n.t('contribution_report_to_project_owner.anonymous')}"
      })
  end
end
