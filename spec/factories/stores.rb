# frozen_string_literal: true
FactoryBot.define do
  factory :store do
    name { Faker::Lorem.word }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
  end
end
