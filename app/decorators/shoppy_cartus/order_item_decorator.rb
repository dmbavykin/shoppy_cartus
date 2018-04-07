# frozen_string_literal: true

module ShoppyCartus
  class OrderItemDecorator < ApplicationDecorator
    delegate_all

    def subtotal
      product.price * quantity
    end
  end
end
