require 'rails_helper'

RSpec.describe VacancySearcher do
  let(:skills) { create_list :skill, rand(3..5)  }
  let(:salary) { rand(100_000..200_000) }
  let(:double_salary) { salary * 2 }

  let(:vacancy_searcher) do
    described_class.new(skill_ids: skills.map(&:id), salary: salary)
  end

  describe '#results' do
    subject { vacancy_searcher.results }

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
  end
end
