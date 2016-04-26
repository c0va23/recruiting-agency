module VacanciesRepresenter
  include Representable::JSON::Collection

  items :extend => VacancyRepresenter
end
