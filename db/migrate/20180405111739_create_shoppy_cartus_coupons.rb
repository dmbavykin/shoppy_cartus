class CreateShoppyCartusCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :shoppy_cartus_coupons do |t|
      t.string :code, null: false
      t.decimal :sale, precision: 5, scale: 2, null: false
      t.references :order, index: true
    end
  end
end
