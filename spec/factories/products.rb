FactoryBot.define do
  factory :product do
    name { Faker::Food.dish }
    sku { Faker::Code.imei }
    type { ['Pizza', 'Complement'].sample }
    price { Faker::Commerce.price.to_i }
  end
end
