module ApplicantsRepresenter
  include Representable::JSON::Collection

  items :extend => ApplicantRepresenter
end
