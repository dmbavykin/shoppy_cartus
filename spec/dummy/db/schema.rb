# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_180_407_105_610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'books', force: :cascade do |t|
    t.string 'title', null: false
    t.decimal 'price', precision: 5, scale: 2, null: false
    t.integer 'publication_year'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'quantity', null: false
  end

  create_table 'shoppy_cartus_addresses', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'address', null: false
    t.string 'city', null: false
    t.string 'zip', null: false
    t.string 'country', null: false
    t.string 'phone', null: false
    t.integer 'kind', null: false
    t.string 'addressable_type'
    t.bigint 'addressable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[addressable_type addressable_id], name: 'index_sh_cart_addresses_on_addressable_type_and_addressable_id'
  end

  create_table 'shoppy_cartus_coupons', force: :cascade do |t|
    t.string 'code', null: false
    t.decimal 'sale', precision: 5, scale: 2, null: false
    t.bigint 'order_id'
    t.index ['order_id'], name: 'index_shoppy_cartus_coupons_on_order_id'
  end

  create_table 'shoppy_cartus_credit_cards', force: :cascade do |t|
    t.string 'number', null: false
    t.integer 'cvv', null: false
    t.bigint 'user_id'
    t.string 'card_name', null: false
    t.string 'expiration_date', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_shoppy_cartus_credit_cards_on_user_id'
  end

  create_table 'shoppy_cartus_deliveries', force: :cascade do |t|
    t.string 'title', null: false
    t.string 'days', null: false
    t.decimal 'price', precision: 5, scale: 2, null: false
    t.boolean 'active', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'shoppy_cartus_order_items', force: :cascade do |t|
    t.decimal 'price', precision: 5, scale: 2, null: false
    t.integer 'quantity', null: false
    t.integer 'product_id'
    t.bigint 'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_shoppy_cartus_order_items_on_order_id'
    t.index ['product_id'], name: 'index_shoppy_cartus_order_items_on_product_id'
  end

  create_table 'shoppy_cartus_orders', force: :cascade do |t|
    t.decimal 'total_price', precision: 6, scale: 2
    t.date 'completed_date'
    t.bigint 'user_id'
    t.string 'state', default: 'filling', null: false
    t.boolean 'use_billing', default: false
    t.string 'confirmation_token'
    t.string 'track_number'
    t.bigint 'delivery_id'
    t.bigint 'credit_card_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['credit_card_id'], name: 'index_shoppy_cartus_orders_on_credit_card_id'
    t.index ['delivery_id'], name: 'index_shoppy_cartus_orders_on_delivery_id'
    t.index ['user_id'], name: 'index_shoppy_cartus_orders_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
  end
end
