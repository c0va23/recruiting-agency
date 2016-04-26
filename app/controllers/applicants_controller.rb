class ApplicantsController < ApplicationController
  include Roar::Rails::ControllerAdditions

  respond_to :json

  def index
    applicants = Applicant.includes(:skills).all

    respond_with applicants
  end

  def show
    applicant = find_applicant

    respond_with applicant
  end

  def create
    applicant = Applicant.create(applicant_params)

    respond_with applicant
  end

  def update
    applicant = find_applicant

    applicant.update_attributes(applicant_params)

    respond_with applicant
  end

  def destroy
    applicant = find_applicant

    applicant.destroy

    respond_with applicant
  end

  private

  def find_applicant
    Applicant.find(params[:id])
  end

  def applicant_params
    params.permit(:name, :contact, :expected_salary, :active, skill_ids: [])
  end
end
