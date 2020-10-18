# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    sequence :email do |i|
      "admin#{i}@example.com"
    end
    password { 'password' }
  end
end
