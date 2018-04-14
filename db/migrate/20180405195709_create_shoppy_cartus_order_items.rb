class CreateShoppyCartusOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shoppy_cartus_order_items do |t|
      t.decimal :price, precision: 5, scale: 2, null: false
      t.integer :quantity, null: false
      t.integer :product_id, index: true
      t.references :order, index: true
      t.timestamps
    end
  end
end
