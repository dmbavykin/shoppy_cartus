FactoryBot.define do
  factory :shoppy_cartus_delivery, class: 'ShoppyCartus::Delivery' do
    title { FFaker::Book.title }
    days { FFaker::Book.description }
    price { rand(1.1...99.9).truncate(2) }
    active { true }
  end
end
