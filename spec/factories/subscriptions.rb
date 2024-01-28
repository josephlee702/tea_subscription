FactoryBot.define do
  factory :subscription do
    customer_name { "Faker::Name.name" }
    email { "Faker::Internet.email" }
  end
end
