class Api::VacanciesController < Api::BaseController
  represents :json, entity: VacancyRepresenter, collection: VacanciesRepresenter

  def index
    vacancies = Vacancy.includes(:skills).all

    respond_with vacancies
  end

  def show
    vacancy = find_vacancy

    respond_with vacancy
  end

  def create
    vacancy = Vacancy.create(vacancy_params)

    respond_with vacancy, location: [:api, vacancy]
  end

  def destroy
    vacancy = find_vacancy

    vacancy.destroy

    respond_with vacancy
  end

  def update
    vacancy = find_vacancy

    vacancy.update_attributes(vacancy_params)

    respond_with vacancy
  end

  def search
    vacancies = VacancySearcher.new(**vacancy_search_params).results

    respond_with vacancies
  end

  private

  def vacancy_params
    params.permit(:name, :contacts, :salary, :validity_days, skill_ids: [])
  end

  def vacancy_search_params
    params.permit(:salary, skill_ids: []).symbolize_keys
  end

  def find_vacancy
    Vacancy.find(params[:id])
  end
end
