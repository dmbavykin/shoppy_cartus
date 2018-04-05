FactoryBot.define do
  factory :shoppy_cartus_order, class: 'ShoppyCartus::Order' do
    total_price { rand(1.1...99.9).truncate(2) }
    completed_date { FFaker::Time.date }
    state { 'filling' }
    user { nil }
  end
end
