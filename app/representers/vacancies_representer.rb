module VacanciesRepresenter
  include Representable::JSON::Collection

  items do
    property :id
    property :name
    property :salary
    property :contacts
    property :validity_days
    property :created_at

    collection :skills do
      property :id
      property :name
    end
  end
end
