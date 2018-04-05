class User < ApplicationRecord
  has_many :credit_cards, class_name: 'ShoppyCartus::CreditCard'
end
