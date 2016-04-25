require 'rails_helper'

RSpec.describe ApplicantSearcher do
  let(:skills) { create_list :skill, rand(3..5) }
  let(:salary) { rand(50_000..150_000) }
  let(:applicant_searcher) { described_class.new(skill_ids: skills.map(&:id), salary: salary) }

  describe '#results' do
    subject { applicant_searcher.results }

    context 'when exist fully matched applicant' do
      let!(:applicant) { create :applicant, skills: skills, expected_salary: salary }

      it 'return applicant' do
        is_expected.to eq [applicant]
      end
    end

    context 'when exist applicant with low expected_salary' do
      let(:low_salary) { salary / 2 }
      let!(:applicant) { create :applicant, skills: skills, expected_salary: low_salary }

      it 'return applicant' do
        is_expected.to eq [applicant]
      end
    end

    context 'when exist applicant with additional skills' do
      let(:additional_skills) { create_list :skill, rand(1..3) }
      let!(:applicant) { create :applicant, skills: skills + additional_skills, expected_salary: salary }

      it 'return applicant' do
        is_expected.to eq [applicant]
      end
    end

    context 'when exist few matched applicants' do
      let(:applicants) do
        rand(3..5).times.map do
          low_salary = rand(0..salary)
          additional_skills = create_list :skill, rand(1..3)
          create :applicant, skills: skills + additional_skills, expected_salary: low_salary
        end
      end

      let(:orderd_appicants) { applicants.sort_by(&:expected_salary) }

      it 'return applicants ordered by expected salary' do
        is_expected.to eq orderd_appicants
      end
    end

    context 'when not exist matched applicant' do
      it { is_expected.to be_empty }
    end

    context 'when exist applicant with hight expected salary' do
      let(:high_salary) { salary * 2 }
      let!(:applicant) { create :applicant, skills: skills, expected_salary: high_salary }

      it { is_expected.to be_empty }
    end

    context 'when exist applicant with partial skills' do
      let(:partial_skills) { skills.sample(rand(skills.count)) }
      let!(:applicant) { create :applicant, skills: partial_skills, expected_salary: salary }

      it { is_expected.to be_empty }
    end

  end
end
