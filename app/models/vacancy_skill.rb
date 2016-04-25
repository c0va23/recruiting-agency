class VacancySkill < ActiveRecord::Base
  belongs_to :vacancy, required: true
  belongs_to :skill, required: true

  validates :skill_id, uniqueness: { scope: :vacancy_id }
end
