FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    preparation_time { Faker::Number.within(range: 1..100) }
    cooking_time { Faker::Number.within(range: 1..100) }
    description { Faker::Food.description }
    public { Faker::Boolean.boolean }
    user_id { Faker::Number.within(range: 1..10) }
  end
end
