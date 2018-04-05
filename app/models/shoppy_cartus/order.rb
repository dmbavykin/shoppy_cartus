module ShoppyCartus
  class Order < ApplicationRecord
    include AASM
    belongs_to :user, optional: true, class_name: ShoppyCartus.user_class
    belongs_to :credit_card, optional: true, class_name: 'ShoppyCartus::CreditCard'
    belongs_to :delivery, optional: true, class_name: 'ShoppyCartus::Delivery'
    has_many :addresses, as: :addressable, dependent: :destroy
    has_many :order_items, dependent: :destroy, class_name: 'ShoppyCartus::OrderItem'
    has_one :coupon, dependent: :nullify, class_name: 'ShoppyCartus::Coupon'
    validates :state, presence: true
    scope :in_progress, -> { find_by(state: 'filling') }
    scope :executed, -> { where.not(state: 'filling') }
    scope :by_state, ->(state) { where(state: state) }
    accepts_nested_attributes_for :addresses

    aasm column: :state do
      state :filling, initial: true
      state :in_confirmation, after_enter: :send_confirmation
      state :in_processing
      state :in_delivery
      state :completed
      state :canceled

      event :confirm do
        transitions from: :filling, to: :in_confirmation
      end

      event :process do
        transitions from: :in_confirmation, to: :in_processing
      end

      event :deliver do
        transitions from: :in_processing, to: :in_delivery
      end

      event :complete do
        transitions from: :in_delivery, to: :completed
      end

      event :cancel do
        transitions from: %i[filling in_confirmation in_processing in_delivery completed], to: :canceled
      end
    end

    def send_confirmation
      ShoppyCartus::OrderMailer.confirm_order(user, self).deliver_now
    end

    def self.aasm_states
      aasm.states.map(&:name)
    end

    def self.active_order_for_user(user)
      find_by(user: user, state: 'filling')
    end
  end
end
