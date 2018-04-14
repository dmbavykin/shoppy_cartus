module ShoppyCartus
  class Delivery < ApplicationRecord
    has_many :orders, dependent: :nullify, class_name: 'ShoppyCartus::Order'
    validates :title, :days, :price, presence: true
  end
end
