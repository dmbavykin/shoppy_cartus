require "shoppy_cartus/engine"
require 'aasm'

module ShoppyCartus
  mattr_accessor :user_class
  @@user_class = 'User'

  mattr_accessor :product_class
  @@product_class = 'Book'

  def self.setup
    yield self
  end
end
