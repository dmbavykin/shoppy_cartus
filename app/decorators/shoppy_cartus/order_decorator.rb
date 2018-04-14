# frozen_string_literal: true

module ShoppyCartus
  class OrderDecorator < ApplicationDecorator
    delegate_all
    decorates_association :order_item

    def sale
      coupon ? coupon.sale : 0.0
    end

    def subtotal
      order_items.map(&:decorate).map(&:subtotal).reduce(&:+)
    end

    def total
      total_price = subtotal - sale
      total_price.positive? ? total_price : 0.0
    end

    def total_with_delivery
      total + delivery.price
    end
  end
end
