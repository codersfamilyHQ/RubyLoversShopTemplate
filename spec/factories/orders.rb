FactoryBot.define do
  factory :order do
    amount { 9.99 }
    p24_session_id { SecureRandom.uuid }
    user
  end
end
