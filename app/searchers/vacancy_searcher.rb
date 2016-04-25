class VacancySearcher
  def initialize(skill_ids:, salary:)
    @skill_ids = skill_ids
    @salary = salary
  end

  def results
    extra_vacancy_skills = VacancySkill
      .where('vacancy_id = vacancies.id')
      .where.not(skill_id: @skill_ids)
    Vacancy
      .where('vacancies.salary >= ?', @salary)
      .where('not exists(?)', extra_vacancy_skills)
      .order(salary: :desc)
  end
end
