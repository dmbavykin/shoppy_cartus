FactoryBot.define do
  factory :shoppy_cartus_credit_card, class: 'ShoppyCartus::CreditCard' do
    number { 16.times.map { rand(10) }.join }
    cvv { rand(111..9999) }
    expiration_date { "#{rand(10..99)}/#{rand(10..99)}" }
    card_name { FFaker::Internet.domain_word }
  end
end
