class CreateShoppyCartusAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :shoppy_cartus_addresses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :zip, null: false
      t.string :country, null: false
      t.string :phone, null: false
      t.integer :kind, null: false
      t.references :addressable, polymorphic: true, index: { name: 'index_sh_cart_addresses_on_addressable_type_and_addressable_id' }
      t.timestamps
    end
  end
end
