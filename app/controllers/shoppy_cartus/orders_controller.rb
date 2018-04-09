module ShoppyCartus
  class OrdersController < ApplicationController

    def index
      @orders = current_user.orders.executed
      @orders = @orders.by_state(params[:state].to_sym) if valid_state?
    end

    def show
      @_order = ShoppyCartus::Order.find_by(id: params[:id]).decorate
    end

    def confirm
      order = ShoppyCartus::Order.find_by(id: params[:order_id])
      if order.confirmation_token == params[:token]
        order.process
        order.save
        return redirect_to main_app.root_path, notice: t('order.confirmed')
      end
      redirect_to main_app.root_path, alert: t('order.wrong_token')
    end

    private

    def valid_state?
      ShoppyCartus::Order.aasm_states.include?(params[:state]&.to_sym)
    end
  end
end
