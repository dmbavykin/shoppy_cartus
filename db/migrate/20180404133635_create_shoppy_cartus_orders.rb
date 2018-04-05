class CreateShoppyCartusOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :shoppy_cartus_orders do |t|
      t.decimal :total_price, precision: 6, scale: 2
      t.date :completed_date
      t.belongs_to :user, index: true
      t.string :state, default: 'filling', null: false
      t.boolean :use_billing, default: false
      t.string :confirmation_token
      t.string :track_number
      t.references :delivery, index: true
      t.references :credit_card, index: true
      t.timestamps
    end
  end
end
