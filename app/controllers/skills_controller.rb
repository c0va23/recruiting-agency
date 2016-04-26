class SkillsController < ApplicationController
  respond_to :json

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

    respond_with skill
  end

  private

  def skill_params
    params.permit(:name)
  end
end
