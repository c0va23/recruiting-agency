class Applicant < ActiveRecord::Base
  validates :name, presence: true
  validates :contact, presence: true
  validates :active, presence: true
  validates :expected_salary, presence: true, numericality: { greater_than: 0 }
end
