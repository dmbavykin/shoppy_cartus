class CreateShoppyCartusDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :shoppy_cartus_deliveries do |t|
      t.string :title, null: false, unique: true
      t.string :days, null: false
      t.decimal :price, precision: 5, scale: 2, null: false
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
