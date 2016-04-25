require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:name) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
