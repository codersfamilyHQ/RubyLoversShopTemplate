# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |i|
      "user#{i}@example.com"
    end
    password { 'password' }
  end
end
