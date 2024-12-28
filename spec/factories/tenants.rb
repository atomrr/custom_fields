FactoryBot.define do
  factory :tenant do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name}
    last_name { Faker::Name.last_name}

    trait :with_fields do
      after :create do |tenant|
        tenant.fields << create(:string_field, tenant: tenant)
        tenant.fields << create(:number_field, tenant: tenant)
        tenant.fields << create(:single_choice, tenant: tenant)
        tenant.fields << create(:multiple_choice, tenant: tenant)
      end
    end
  end
end
