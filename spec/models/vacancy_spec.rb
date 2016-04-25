require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:validity_days).of_type(:integer) }
    it { is_expected.to have_db_column(:salary).of_type(:decimal) }
    it { is_expected.to have_db_column(:contacts).of_type(:text) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  end
end
