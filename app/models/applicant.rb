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

  validates :name, presence: true, format: { with: NAME_REGEXP }
  validates :contact, presence: true
  validates :expected_salary, presence: true, numericality: { greater_than: 0 }
end
