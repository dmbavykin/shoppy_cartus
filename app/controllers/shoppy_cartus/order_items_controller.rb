require_dependency 'shoppy_cartus/application_controller'

module ShoppyCartus
  class OrderItemsController < ApplicationController
    load_and_authorize_resource class: 'ShoppyCartus::OrderItem'

    def index
      @items = @order.order_items.map(&:decorate) if @order.order_items.any?
    end

    def create
      if @order.order_items.where(product_id: order_items_params[:product_id]).any?
        return redirect_to order_items_path, alert: t('cart.alredy_added')
      end
      @order.order_items.create(order_items_params)
      redirect_to order_items_path, notice: t('cart.successful_added')
    end

    def update
      params[:increment] ? increment : decrement
      redirect_to order_items_path
    end

    def destroy
      @order_item.destroy
      redirect_to order_items_path, notice: t('cart.removed_successful')
    end

    private

    def order_items_params
      params.require(:order_items).permit(:price, :quantity, :product_id)
    end

    def increment
      return flash[:alert] = t('cart.no_more') if @order_item.quantity == @order_item.product.quantity
      @order_item.increment!(:quantity)
    end

    def decrement
      return flash[:alert] = t('cart.no_less') if @order_item.quantity == 1
      @order_item.decrement!(:quantity)
    end
  end
end
