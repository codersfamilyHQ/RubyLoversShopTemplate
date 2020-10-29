FactoryBot.define do
  factory :order do
    amount { "9.99" }
    currency { 1 }
    p24_session_id { "MyString" }
    p24_method { "MyString" }
    user { nil }
  end
end
