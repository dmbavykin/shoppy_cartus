module ShoppyCartus
  class OrdersController < ApplicationController
    before_action "authenticate_#{ShoppyCartus.user_class.downcase}!".to_sym
    # authorize_resource class: 'ShoppyCartus::Order'

    def index
      authorize! :index, ShoppyCartus::Order
      @orders = current_user.orders.executed
      @orders = @orders.by_state(params[:state].to_sym) if valid_state?
    end

    def show
      @_order = ShoppyCartus::Order.find_by(id: params[:id]).decorate
      authorize! :show, @_order.object
    end

    def confirm
      order = ShoppyCartus::Order.find_by(id: params[:order_id])
      if order.confirmation_token == params[:token]
        authorize! :confirm, order
        order.process
        order.save
        return redirect_to order_items_path, notice: t('order.confirmed')
      end
      redirect_to order_items_path, alert: t('order.wrong_token')
    end

    private

    def valid_state?
      ShoppyCartus::Order.aasm_states.include?(params[:state]&.to_sym)
    end
  end
end
