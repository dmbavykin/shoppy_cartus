class AddQuantityToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :quantity, :integer, null: false
  end
end
