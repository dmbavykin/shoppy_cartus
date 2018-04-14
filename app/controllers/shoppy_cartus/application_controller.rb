module ShoppyCartus
  class ApplicationController < ShoppyCartus.parent_controller.constantize
    before_action :set_order, :set_locale, :current_ability

    [CanCan::AccessDenied, ActiveRecord::RecordNotFound, ActionController::RoutingError].each do |error|
      rescue_from error do |exception|
        redirect_to order_items_path, alert: exception.message
      end
    end

    define_method "authenticate_#{ShoppyCartus.user_class.downcase}!" do
      return if current_user
      redirect_to order_items_path, alert: t('checkout.authorize')
    end

    def current_order
      ShoppyCartus::Order.find_by(id: session[:order_id]) || ShoppyCartus::Order.active_order_for_user(current_user) || new_session_order
    end

    def current_ability
      @current_ability ||= Ability.new(current_user, current_order)
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(*)
      { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
    end

    private

    def set_order
      @order ||= current_order.decorate
    end

    def new_session_order
      order = ShoppyCartus::Order.create(user: current_user)
      session[:order_id] = order.id
      order
    end
  end
end
