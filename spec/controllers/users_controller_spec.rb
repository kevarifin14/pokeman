require 'rails_helper'

RSpec.describe UsersController do
  let(:user) { create(User) }
  let(:code) { 'access_token'}

  describe 'patch #update' do
    def patch_update
      patch :update, id: user, code: code
    end

    before do
      patch_update
      user.reload
    end

    it 'updates the correct access_token' do
      expect(user.access_token).to eq(code)
    end

    it 'redirects back to the root path' do
      expect(response).to redirect_to(root_path)
    end
  end
end
