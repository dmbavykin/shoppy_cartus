require 'shoppy_cartus/engine'
require 'digest'
require 'aasm'
require 'cancancan'
require 'draper'
require 'wicked'
require 'country_select'
require 'haml'
require 'sass-rails'
require 'bootstrap-sass'
require 'font-awesome-rails'
require 'simple_form'
require 'jquery-rails'
require 'turbolinks'

module ShoppyCartus
  mattr_accessor :user_class
  @@user_class = 'User'

  mattr_accessor :product_class
  @@product_class = 'Book'

  mattr_accessor :parent_controller
  @@parent_controller = 'ApplicationController'

  def self.setup
    yield self
  end
end
