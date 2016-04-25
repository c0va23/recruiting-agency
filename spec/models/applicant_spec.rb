require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:contact).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:active).of_type(:boolean).with_options(null: false) }
    it { is_expected.to have_db_column(:expected_salary).of_type(:decimal).with_options(null: false) }
  end

  describe 'validations' do
    describe 'name' do
      let(:valid_name) { attributes_for(:applicant)[:name] }

      let(:valid_name_without_patronymic) do
        [
          FFaker::NameRU.first_name,
          FFaker::NameRU.last_name,
        ].join(' ')
      end

      it { is_expected.to validate_presence_of(:name) }

      it 'allow valid name' do
        is_expected.to allow_value(valid_name).for(:name)
      end

      it 'not allow english name' do
        is_expected.to_not allow_value(FFaker::Name.name).for(:name)
      end

      it 'not allow valid name with new line' do
        is_expected.to_not allow_value(valid_name + "\n<script>alert('Hi!');</script>").for(:name)
      end

      it 'not allow name without patronymic' do
        is_expected.to_not allow_value(valid_name_without_patronymic).for(:name)
      end
    end

    it { is_expected.to validate_presence_of(:contact) }
    it 'allow phone number for contact'
    it 'allow email for contact'

    it { is_expected.to validate_presence_of(:expected_salary) }
    it { is_expected.to validate_numericality_of(:expected_salary).is_greater_than(0) }
  end
end
