require 'rails_helper'

describe UsersController, type: :request do
  let!(:user) { create :user}
  let(:user_stub_attrs) { build(:user).attributes.filter { | key, value| value.present? } }
  let(:first_name) { Faker::Name.first_name }
  let(:tenant_with_fields) { create :tenant, :with_fields }

  let!(:with_fields) { create :user, tenant: tenant_with_fields}

  let(:fields_list) { tenant_with_fields.fields.pluck(:name)}

  describe 'GET user' do
    it 'returns status 200' do
      get "/users/#{user.id}"

      expect(response.status).to eq(200)
    end
  end

  describe 'POST user' do
    it 'creates user' do
      expect do
        post "/users/", params: user_stub_attrs.merge!(tenant_id: Tenant.all.sample.id)
      end.to change(User, :count).by(1)
    end
  end

  describe 'PATCH user' do
    it 'updates user' do
      patch "/users/#{user.id}", params: { first_name: first_name }

      expect(response.status).to eq(200)
      expect(user.reload.first_name).to eq(first_name)
    end

    it 'updates string field' do
      word = Faker::Lorem.word
      patch "/users/#{with_fields.id}", params: { "#{fields_list.first}": word }

      expect(with_fields.reload.public_send(fields_list.first.to_sym)).to eq(word)
    end

    it 'updates number field' do
      number = Faker::Number.number
      patch "/users/#{with_fields.id}", params: { "#{fields_list.second}": number }

      expect(with_fields.reload.public_send(fields_list.second.to_sym)).to eq(number.to_s)
    end

    it 'updates single choice field' do
      insurance = 'none'
      patch "/users/#{with_fields.id}", params: { "#{fields_list.third}": insurance }

      expect(with_fields.reload.public_send(fields_list.third.to_sym)).to eq(insurance)
    end

    it 'updates multiple choice field' do
      pets = ['dog', 'cat']
      patch "/users/#{with_fields.id}", params: { "#{fields_list.last}": pets }

      expect(with_fields.reload.public_send(fields_list.last.to_sym)).to eq(pets)
    end

    it 'validates number field' do
      number = Faker::Lorem.word
      patch "/users/#{with_fields.id}", params: { "#{fields_list.second}": number }

      expect(response.status).to eq(422)
      expect(response.body).to include('is not a number')
    end

    it 'validates single choice field' do
      insurance = 'dental'
      patch "/users/#{with_fields.id}", params: { "#{fields_list.third}": insurance }

      expect(response.status).to eq(422)
      expect(response.body).to include('is not included in the list')
    end

    it 'validates multiple choice field' do
      pets = ['dog', 'tiger']
      patch "/users/#{with_fields.id}", params: { "#{fields_list.last}": pets }

      expect(response.status).to eq(422)
      expect(response.body).to include('is not included in the list')
    end
  end
end
