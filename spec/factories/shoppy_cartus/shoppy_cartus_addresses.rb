FactoryBot.define do
  factory :shoppy_cartus_address, class: 'ShoppyCartus::Address' do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country }
    phone { FFaker::PhoneNumberFR.international_phone_number }

    trait :shipping do
      kind :shipping
    end

    trait :billing do
      kind :billing
    end

    trait :invalid do
      zip nil
    end
  end
end
