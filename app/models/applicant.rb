class Applicant < ActiveRecord::Base
  NAME_REGEXP = %r{
    \A
    \p{Cyrillic}+
    \ # Space
    \p{Cyrillic}+
    \ # Space
    \p{Cyrillic}+
    \z
  }xi

  CONTACT_REGEXP = %r{
    \w+@(\w+\.)+\w+
    |
    \+7([\(\)\-\ ]*\d){10}
  }xi

  validates :name, presence: true, format: { with: NAME_REGEXP }
  validates :contact, presence: true, format: { with: CONTACT_REGEXP }
  validates :expected_salary, presence: true, numericality: { greater_than: 0 }

  has_many :applicant_skills
  has_many :skills, through: :applicant_skills
end
