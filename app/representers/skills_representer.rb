module SkillsRepresenter
  include Representable::JSON::Collection

  items :extend => SkillRepresenter
end
