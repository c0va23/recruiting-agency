require 'rails_helper'

RSpec.describe ApplicantSearcher do
  let(:skills) { create_list :skill, rand(3..5) }
  let(:salary) { rand(50_000..150_000) }
  let(:applicant_searcher) do
    described_class.new(skill_ids: skills.map(&:id), salary: salary)
  end

  describe '#results' do
    subject { applicant_searcher.results }

    context 'when exist fully matched applicant' do
      let!(:applicant) do
        create :applicant, skills: skills, expected_salary: salary
      end

      it 'return applicant' do
        is_expected.to eq [applicant]
      end
    end

    context 'when exist applicant with low expected_salary' do
      let(:low_salary) { salary / 2 }
      let!(:applicant) do
        create :applicant, skills: skills, expected_salary: low_salary
      end

      it 'return applicant' do
        is_expected.to eq [applicant]
      end
    end

    context 'when exist applicant with additional skills' do
      let(:additional_skills) { create_list :skill, rand(1..3) }
      let(:extended_skills) { skills + additional_skills }
      let!(:applicant) do
        create :applicant, skills: extended_skills, expected_salary: salary
      end

      it 'return applicant' do
        is_expected.to eq [applicant]
      end
    end

    context 'when exist few matched applicants' do
      let(:additional_skills) { create_list :skill, rand(3..5) }
      let(:applicants) do
        Array.new(rand(3..5)) do
          create :applicant,
                 skills: skills + additional_skills.sample(3),
                 expected_salary: rand(0..salary)
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
      let!(:applicant) do
        create :applicant, skills: skills, expected_salary: high_salary
      end

      it { is_expected.to be_empty }
    end

    context 'when exist applicant with partial skills' do
      let(:partial_skills) { skills.sample(rand(1...skills.count)) }
      let!(:applicant) do
        create :applicant, skills: partial_skills, expected_salary: salary
      end

      it { is_expected.to be_empty }
    end

    context 'when exist applicant not active' do
      let!(:applicant) do
        create :applicant,
               skills: skills,
               expected_salary: salary,
               active: false
      end

      it { is_expected.to be_empty }
    end
  end
end
