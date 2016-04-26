class Api::SkillsController < Api::BaseController
  represents :json, entity: SkillRepresenter, collection: SkillsRepresenter

  def index
    skills = Skill.all

    respond_with skills
  end

  def show
    skill = Skill.find(params[:id])

    respond_with skill
  end

  def create
    skill = Skill.create(skill_params)

    respond_with skill, location: [:api, skill]
  end

  private

  def skill_params
    params.permit(:name)
  end
end
