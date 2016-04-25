class ApplicantSearcher
  def initialize(skill_ids:, salary:)
    @skill_ids = skill_ids
    @salary = salary
  end

  def results
    applicant_matched_skill_count = ApplicantSkill
      .where('applicant_id = applicants.id')
      .where(skill_id: @skill_ids)
      .select('count(1)')
    Applicant
      .where('expected_salary <= ?', @salary)
      .where('(?) = ?', applicant_matched_skill_count, @skill_ids.count)
      .order(:expected_salary)
  end
end
