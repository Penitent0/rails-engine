FactoryBot.define do
  factory :invoice_item do
    unit_price { 1.5 }
    invoice { nil }
    item { nil }
  end
end
