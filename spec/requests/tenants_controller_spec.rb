require 'rails_helper'

describe TenantsController, type: :request do
  let!(:tenant) { create :tenant}
  let(:tenant_stub_attrs) { build(:tenant).attributes.filter { | key, value| value.present? } }
  let(:first_name) { Faker::Name.first_name }
  let(:fields_attributes) do
    [{
        name: 'nickname',
        type: 'StringField'
    },
    {
        name: 'level',
        type: 'SingleChoice',
        data: %w(1 2 3)
    }]
  end

  describe 'GET tenant' do
    it 'returns status 200' do
      get "/tenants/#{tenant.id}"

      expect(response.status).to eq(200)
    end
  end

  describe 'POST tenant' do
    it 'creates tenant' do
      expect do
        post "/tenants/", params: tenant_stub_attrs
      end.to change(Tenant, :count).by(1)
    end
  end

  describe 'PATCH tenant' do
    it 'updates tenant' do
      patch "/tenants/#{tenant.id}", params: { first_name: first_name }

      expect(response.status).to eq(200)
      expect(tenant.reload.first_name).to eq(first_name)
    end

    it 'updates tenant fields' do
      expect do
        patch "/tenants/#{tenant.id}", params: { fields_attributes: fields_attributes }
      end.to  change(tenant.fields, :count).by(2)
    end
  end

end
