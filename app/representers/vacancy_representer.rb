module VacancyRepresenter
  include Roar::JSON

  property :id
  property :name
  property :salary
  property :validity_days
  property :created_at

  property :skill_ids
end
