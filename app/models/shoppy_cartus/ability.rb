# frozen_string_literal: true

module ShoppyCartus
  class Ability
    include CanCan::Ability

    def initialize(user, order)
      user ||= ShoppyCartus.user_class.constantize.new

      can :manage, OrderItem, order_id: order.id
      can :manage, Coupon, order_id: order.id
      can :manage, Order, user_id: user.id
      can %i[create update], CreditCard, user_id: user.id
    end
  end
end
