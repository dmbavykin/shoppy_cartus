module ShoppyCartus
  class Coupon < ApplicationRecord
    belongs_to :order, optional: true, class_name: 'ShoppyCartus::Order'
    validates :code, :sale, presence: true
  end
end
