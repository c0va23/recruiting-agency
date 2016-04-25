require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:contact).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:active).of_type(:boolean).with_options(null: false) }
    it { is_expected.to have_db_column(:expected_salary).of_type(:decimal).with_options(null: false) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it 'allow valid name'
    it 'allow invalid name'

    it { is_expected.to validate_presence_of(:contact) }
    it 'allow phone number for contact'
    it 'allow email for contact'

    it { is_expected.to validate_presence_of(:active) }

    it { is_expected.to validate_presence_of(:expected_salary) }
    it { is_expected.to validate_numericality_of(:expected_salary).is_greater_than(0) }
  end
end
