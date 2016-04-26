require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:validity_days).of_type(:integer) }
    it { is_expected.to have_db_column(:salary).of_type(:decimal) }
    it { is_expected.to have_db_column(:contacts).of_type(:text) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:validity_days) }
    it { is_expected.to validate_numericality_of(:validity_days).is_greater_than(0) }

    it { is_expected.to validate_presence_of(:salary) }
    it { is_expected.to validate_numericality_of(:salary).is_greater_than(0) }

    it { is_expected.to validate_presence_of(:contacts) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:vacancy_skills).dependent(:destroy) }
    it { is_expected.to have_many(:skills).through(:vacancy_skills) }
  end
end
