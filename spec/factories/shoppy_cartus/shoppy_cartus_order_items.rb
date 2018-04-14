FactoryBot.define do
  factory :shoppy_cartus_order_item, class: 'ShoppyCartus::OrderItem' do
    price { rand(1.1...99.9).truncate(2) }
    quantity { rand(1..10) }
    product { create :product }
    order { create :shoppy_cartus_order }
  end
end
