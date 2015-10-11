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
    it { is_expected.to have_db_column(:access_token).of_type(:string) }
  end

  describe '#level' do
    let(:user) { create(User, experience_points: experience_points) }
    let(:experience_points) { 0 }
    specify { expect(user.level).to eq(1) }
  end
end
