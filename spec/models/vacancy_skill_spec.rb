require 'rails_helper'

RSpec.describe VacancySkill, type: :model do
  describe 'schema' do
    it { is_expected.to have_db_column(:vacancy_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:skill_id).of_type(:integer).with_options(null: false) }

    it { is_expected.to have_db_index([:vacancy_id, :skill_id]).unique(true) }
  end

  describe 'references' do
    it { is_expected.to belong_to(:vacancy) }
    it { is_expected.to belong_to(:skill) }
  end

  describe 'validates' do
    subject { build :vacancy_skill }

    it { is_expected.to validate_presence_of(:vacancy) }
    it { is_expected.to validate_presence_of(:skill) }
    it { is_expected.to validate_uniqueness_of(:skill_id).scoped_to(:vacancy_id) }
  end
end
