module ShoppyCartus
  class OrderStepsController < ApplicationController
    include Wicked::Wizard
    steps :address, :delivery, :payment, :confirm, :complete
    before_action "authenticate_#{ShoppyCartus.user_class.downcase}!".to_sym, :check_order, :relate_with_user,
                  :set_form, :set_needful_step

    def index
      redirect_to_step(@needful_step)
    end

    def show
      redirect_to_step(@needful_step) && return if wrong_step?
      render_wizard
      session[:order_id] = nil if step == :complete
    end

    def update
      redirect_to_step(next_step) && return if @form.update(step, order_params)
      render_wizard
    end

    private

    def check_order
      redirect_to order_items_path, alert: t('cart.empty') unless ShoppyCartus::OrderItem.where(order: @order).any?
    end

    def relate_with_user
      @order.update(user: current_user) unless @order.user
    end

    def set_form
      @form = ShoppyCartus::OrderStepsForm.new(@order)
    end

    def redirect_to_step(needful_step)
      redirect_to wizard_path(needful_step)
    end

    def wrong_step?
      (step != @needful_step) && step_index(step) > step_index(@needful_step)
    end

    def step_index(_step)
      wizard_steps.index(_step)
    end

    def set_needful_step
      @needful_step = @form.get_step
    end

    def order_params
      params.permit(
        :use_billing,
        :delivery,
        credit_card: %i[number cvv card_name expiration_date],
        billing_address:  %i[first_name last_name address city zip country phone kind],
        shipping_address: %i[first_name last_name address city zip country phone kind]
      )
    end
  end
end
