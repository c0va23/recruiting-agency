require 'rails_helper'

RSpec.describe ApplicantSkill, type: :model do
  describe 'schema' do
    it { is_expected.to have_db_column(:applicant_id) }
    it { is_expected.to have_db_column(:skill_id) }

    it { is_expected.to have_db_index([:applicant_id, :skill_id]).unique(true) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:applicant) }
    it { is_expected.to belong_to(:skill) }
  end

  describe 'validation' do
    subject { build :applicant_skill }

    it { is_expected.to validate_presence_of(:applicant) }
    it { is_expected.to validate_presence_of(:skill) }

    it { is_expected.to validate_uniqueness_of(:skill_id).scoped_to(:applicant_id) }
  end
end
