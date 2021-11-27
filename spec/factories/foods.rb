FactoryBot.define do
  factory :food do
    name { Faker::Movies::StarWars.character }
    measurement_unit { 'Teaspoon (tsp)' }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    user_id { Faker::Number.within(range: 1..10) }
  end
end