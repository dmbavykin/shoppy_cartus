# frozen_string_literal: true

module ShoppyCartus
  class CouponsController < ApplicationController
    authorize_resource class: 'ShoppyCartus::Coupon'

    def create
      coupon = ShoppyCartus::Coupon.find_by(code: coupon_params[:code])
      return redirect_to order_items_path, alert: t('coupon.not_exist') unless coupon
      return redirect_to order_items_path, alert: t('coupon.used') if coupon.order
      @order.update(coupon: coupon)
      redirect_to order_items_path, notice: t('coupon.added')
    end

    def destroy
      @order.coupon.update(order_id: nil)
      redirect_to order_items_path, notice: t('coupon.removed')
    end

    private

    def coupon_params
      params.require(:coupon).permit(:code)
    end
  end
end
