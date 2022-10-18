FactoryBot.define do
  factory :invoice_item do
    status { "MyString" }
    unit_price { 1.5 }
    invoice { nil }
    item { nil }
  end
end
