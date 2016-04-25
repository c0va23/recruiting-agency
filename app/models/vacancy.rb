class Vacancy < ActiveRecord::Base
  validates :name, presence: true
  validates :validity_days, presence: true, numericality: { greater_than: 0 }
  validates :salary, presence: true, numericality: { greater_than: 0 }
  validates :contacts, presence: true
end
