FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price { 1.5 }
    association :merchant, factory: :merchant
  end
end
