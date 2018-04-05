module ShoppyCartus
  class OrderItem < ApplicationRecord
    belongs_to :order, class_name: 'ShoppyCartus::Order'
    belongs_to :product, class_name: ShoppyCartus.product_class
    validates :price, :quantity, presence: true
  end
end
