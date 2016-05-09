class ApplicantSearcher
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
    base_applicants_query
      .where(where_statement)
      .order("(#{applicant_matched_skill_count.to_sql}) DESC")
      .order(:expected_salary)
  end

  private

  def applicant_matched_skill_count
    ApplicantSkill
      .where('applicant_id = applicants.id')
      .where(skill_id: @skill_ids)
      .select('count(1)')
  end

  def base_applicants_query
    Applicant.where(active: true)
  end

  def where_statement
    @partial_match ? partial_where_statement : fully_where_statement
  end

  def partial_where_statement
    [
      '(?) >= 1',
      applicant_matched_skill_count,
    ]
  end

  def fully_where_statement
    [
      'expected_salary <= ? AND (?) = ?',
      @salary,
      applicant_matched_skill_count,
      @skill_ids.count,
    ]
  end
end
