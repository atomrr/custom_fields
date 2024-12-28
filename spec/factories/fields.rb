FactoryBot.define do
  factory :string_field do
    name { 'nickname' }
    type { 'StringField'}
    tenant
  end

  factory :number_field do
    name { 'age' }
    type { 'NumberField'}
    tenant
  end

  factory :single_choice do
    name { 'insurance' }
    type { 'SingleChoice'}
    data { ['none', 'partial', 'full'] }
    tenant
  end

  factory :multiple_choice do
    name { 'pets' }
    type { 'MultipleChoice'}
    data { ['dog', 'cat', 'bird', 'hamster'] }
    tenant
  end
end
