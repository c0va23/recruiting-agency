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

    describe 'contact' do
      let(:simple_phone_number) { format '+7%010d', rand(999_99_999_999) }
      let(:complex_phone_number) do
        '+7 (%03d) %02d-%03d-%03d' % [rand(999), rand(99), rand(999), rand(999)]
      end

      it { is_expected.to validate_presence_of(:contact) }

      it 'allow simple phone number for contact' do
        is_expected.to allow_value(simple_phone_number).for(:contact)
      end

      it 'allow complex phone number for contact' do
        is_expected.to allow_value(complex_phone_number).for(:contact)
      end

      it 'allow email for contact' do
        is_expected.to allow_value(FFaker::Internet.email).for(:contact)
      end

      it 'not allow contact without phone or email' do
        is_expected.to_not allow_value(FFaker::Lorem.sentence).for(:contact)
      end
    end

    describe 'expected_salary' do
      it { is_expected.to validate_presence_of(:expected_salary) }
      it { is_expected.to validate_numericality_of(:expected_salary).is_greater_than(0) }
    end

    describe 'active' do
      it { is_expected.to allow_value(true).for(:active) }
      it { is_expected.to allow_value(false).for(:active) }
      it { is_expected.to_not allow_value(nil).for(:active) }
    end
  end

  describe 'association' do
    it { is_expected.to have_many(:applicant_skills).dependent(:destroy) }
    it { is_expected.to have_many(:skills).through(:applicant_skills) }
  end
end
