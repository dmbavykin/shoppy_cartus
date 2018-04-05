module ShoppyCartus
  class Address < ApplicationRecord
    belongs_to :addressable, polymorphic: true
    validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :kind, presence: true
    enum kind: %i[billing shipping]
  end
end
