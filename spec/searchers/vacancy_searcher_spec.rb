require 'rails_helper'

RSpec.describe VacancySearcher do
  let(:skills) { create_list :skill, rand(3..5)  }
  let(:salary) { rand(100_000..200_000) }
  let(:double_salary) { salary * 2 }

  let(:vacancy_searcher) do
    described_class.new(
      skill_ids: skills.map(&:id),
      salary: salary,
      partial_match: partial_match,
    )
  end

  describe '#results' do
    subject { vacancy_searcher.results }

    context 'without partial match' do
      let(:partial_match) { false }

      context 'when exist fully matched vacancy' do
        let!(:vacancy) { create :vacancy, skills: skills, salary: salary }

        it 'return vacancy' do
          is_expected.to eq [vacancy]
        end
      end

      context 'when exist vacancy with high salary' do
        let!(:vacancy) { create :vacancy, skills: skills, salary: rand(salary..double_salary) }

        it 'return vacancy' do
          is_expected.to eq [vacancy]
        end
      end

      context 'when exit vacancy with partial skills' do
        let(:partial_skills) { skills.sample(rand(1..skills.count)) }
        let!(:vacancy) { create :vacancy, skills: partial_skills, salary: salary }

        it 'return vacancy' do
          is_expected.to eq [vacancy]
        end
      end

      context 'when exist few matched vacancies' do
        let!(:vacancies) do
          rand(3..5).times.map do
            partial_skills = skills.sample(rand(1..skills.count))
            high_salary = rand(salary..double_salary)
            create :vacancy, skills: partial_skills, salary: high_salary
          end
        end

        let(:ordered_vacancies) { vacancies.sort_by { |v| -v.salary } }

        it 'return vacancies order by salary by descendent' do
          is_expected.to eq ordered_vacancies
        end
      end

      context 'when not exist matched vacancy' do
        it { is_expected.to be_empty }
      end

      context 'when exist vacancy with low salary' do
        let!(:vacancy) { create :vacancy, skills: skills, salary: rand(salary) }

        it { is_expected.to be_empty }
      end

      context 'when exist vacancy with additional skills' do
        let(:additional_skills) { create_list :skill, rand(1..3) }
        let!(:vacancy) { create :vacancy, salary: salary, skills: skills + additional_skills }

        it { is_expected.to be_empty }
      end

      context 'when exist vacancy is expired' do
        let!(:vacancy) { create :vacancy, salary: salary, skills: skills, created_at: 1.year.ago }

        it { is_expected.to be_empty }
      end
    end # context 'without partial match'

    context 'with partial match' do
      let(:partial_match) { true }

      context 'when exist vacancy with other skills' do
        let!(:vacancy) { create :vacancy }

        it { is_expected.to be_empty }
      end

      context 'when exist vacancy with fully equal skills' do
        let!(:vacancy) { create :vacancy, skills: skills.shuffle }

        it 'return vacancy with fully equal' do
          is_expected.to eq [vacancy]
        end
      end

      context 'when exist vacancy with partial skills' do
        let!(:vacancy) { create :vacancy, skills: skills.sample(rand(1..skills.count)) }

        it 'return vacancy with partial skills' do
          is_expected.to eq [vacancy]
        end
      end

      context 'when exist vacancies with full and partial skills' do
        let!(:ordered_vacancies) do
          skills.count.downto(1).flat_map do |vacancies_count|
            rand(3..5).downto(1).map do |salary_index|
              create :vacancy,
                skills: skills.sample(vacancies_count),
                salary: (salary / 2) * salary_index
            end
          end
        end

        it 'return vacancies ordered by skills count and salary' do
          is_expected.to eq ordered_vacancies
        end
      end
    end
  end # describe '#results'
end
