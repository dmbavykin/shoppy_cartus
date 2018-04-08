FactoryBot.define do
  factory :shoppy_cartus_coupon, class: 'ShoppyCartus::Coupon' do
    code { FFaker::Color.hex_code }
    sale { rand(1.1..99.9).truncate(2) }
    order { create :shoppy_cartus_order }

    trait :invalid do
      code nil
    end

    trait :without_order do
      order nil
    end
  end
end
