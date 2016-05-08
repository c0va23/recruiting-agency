module ApplicantsRepresenter
  include Representable::JSON::Collection

  items do
    property :id
    property :name
    property :contact
    property :expected_salary
    property :active
    property :created_at

    collection :skills do
      property :id
      property :name
    end
  end
end
