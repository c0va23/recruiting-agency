class ApplicantSkill < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :skill

  validates :applicant, presence: true
  validates :skill, presence: true

  validates :skill_id, uniqueness: { scope: :applicant_id }
end
