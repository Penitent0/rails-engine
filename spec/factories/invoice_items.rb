FactoryBot.define do
  factory :invoice_item do
    quantity { 10 }
    unit_price { 1.5 }
    invoice { nil }
    item { nil }
  end
end
