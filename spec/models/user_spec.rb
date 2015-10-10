require 'rails_helper'

RSpec.describe User do
  describe '#columns' do
    it do
      is_expected.to have_db_column(:username).of_type(:string)
        .with_options(null: false, default: '')
    end

    it do
      is_expected.to have_db_column(:email).of_type(:string)
        .with_options(null: false, default: '')
    end

    it do
      is_expected.to have_db_column(:encrypted_password).of_type(:string)
        .with_options(null: false, default: '')
    end

    it { is_expected.to have_db_column(:experience_points).of_type(:decimal) }
  end
end
