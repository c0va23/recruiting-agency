module ApplicantRepresenter
  include Roar::JSON

  property :id
  property :name
  property :contact
  property :expected_salary
  property :active
  property :created_at
  property :skill_ids
end
