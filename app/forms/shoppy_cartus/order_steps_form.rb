module ShoppyCartus
  class OrderStepsForm
    include ActiveModel::Model
    attr_accessor :billing_address, :shipping_address, :deliveries, :credit_card

    def initialize(order)
      @order = order
      @billing_address ||= address(:billing)
      @shipping_address ||= address(:shipping)
      @deliveries ||= Delivery.where(active: true)
      @credit_card ||= set_card
    end

    def update(step, params)
      case step
      when :address then update_addresses(params)
      when :delivery then update_delivery(params)
      when :payment then update_payment(params)
      when :confirm then confirm_order
      end
    end

    def get_step
      case false
      when !nil_or_invalid?(@billing_address) && !nil_or_invalid?(@shipping_address) then :address
      when !@order.delivery.nil? then :delivery
      when !nil_or_invalid?(@credit_card) then :payment
      when !@order.filling? then :confirm
      else :complete
      end
    end

    private

    def address(kind)
      @order.addresses.find_by(kind: kind)
    end

    def update_addresses(params)
      @order.update(use_billing: params[:use_billing] || false)
      @billing_address = update_address(:billing, params[:billing_address])
      update_shipping_address(params)
      @billing_address.errors.empty? && @shipping_address.errors.empty?
    end

    def update_shipping_address(params)
      params_key = params[:use_billing] ? :billing_address : :shipping_address
      shipping_params = params[params_key]
      shipping_params[:kind] = :shipping
      @shipping_address = update_address(:shipping, shipping_params)
    end

    def update_address(kind, params)
      address = @order.addresses.find_by(kind: kind)
      address ? address.update(params) : address = @order.addresses.create(params)
      address
    end

    def update_delivery(params)
      @order.update(delivery_id: params[:delivery])
    end

    def update_payment(params)
      credit_card_params = params[:credit_card].merge(user: @order.user)
      @credit_card ? @credit_card.update(credit_card_params) : @credit_card = CreditCard.create(credit_card_params)
      @order.update(credit_card_id: credit_card.id) if @credit_card.errors.empty?
    end

    def confirm_order
      track_number = "R#{Time.now.strftime('%d%m%y%H%M%S')}"
      @order.update(
        total_price: @order.total_with_delivery,
        confirmation_token: Digest::MD5.hexdigest(track_number),
        track_number: track_number
      )
      @order.confirm
      @order.save
    end

    def set_card
      @order.credit_card || @order.user.credit_cards.last
    end

    def nil_or_invalid?(obj)
      obj.nil? || obj.invalid?
    end
  end
end
