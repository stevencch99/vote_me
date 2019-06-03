FactoryBot.define do
  factory :product do
    title { Faker::FunnyName.name }
    price { Faker::Number.between(10, 20) }
    description { Faker::Lorem.paragraph }
    is_available { Faker::Boolean.boolean }

    trait :ruby do
      title { 'ruby' }
    end

    trait :free do
      price { 0 }
    end
  end
end
