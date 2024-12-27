require 'rails_helper'

describe UsersController, type: :request do
  let!(:user) { create :user}

  describe 'GET user' do
    it 'returns status 200' do
      get "/users/#{user.id}"

      expect(response.status).to eq(200)
    end
  end
end
