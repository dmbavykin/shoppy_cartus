class User < ApplicationRecord
  has_many :credit_cards, class_name: 'ShoppyCartus::CreditCard'
  has_many :orders, class_name: 'ShoppyCartus::Order'
end
