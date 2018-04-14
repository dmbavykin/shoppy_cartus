class CreateShoppyCartusCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :shoppy_cartus_credit_cards do |t|
      t.string :number, null: false
      t.integer :cvv, null: false
      t.bigint :user_id, index: true
      t.string :card_name, null: false
      t.string :expiration_date, null: false
      t.timestamps
    end
  end
end
