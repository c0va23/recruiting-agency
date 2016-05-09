class VacancySearcher
  def initialize(
    skill_ids: [],
    salary: 0,
    partial_match: false
  )
    @skill_ids = skill_ids
    @salary = salary
    @partial_match = partial_match
  end

  def results
    Vacancy
      .where("created_at + validity_days * interval '1 day' > ?", Time.current)
      .where(@partial_match ? partial_criterion : fully_criterion)
      .order(@partial_match ? partial_order : fully_order)
  end

  private

  def vacancy_skills_count
    VacancySkill
      .where('vacancy_id = vacancies.id')
      .where(skill_id: @skill_ids)
      .select('count(1)')
  end

  def partial_criterion
    ['(?) >= 1', vacancy_skills_count]
  end

  def extra_vacancy_skills
    VacancySkill
      .where('vacancy_id = vacancies.id')
      .where.not(skill_id: @skill_ids)
  end

  def fully_criterion
    ['(vacancies.salary >= ?) AND not exists(?)', @salary, extra_vacancy_skills]
  end

  def partial_order
    "(#{vacancy_skills_count.to_sql}) DESC, salary DESC"
  end

  def fully_order
    {salary: :desc}
  end
end
