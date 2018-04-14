class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string 'title', null: false
      t.decimal 'price', precision: 5, scale: 2, null: false
      t.integer 'publication_year'

      t.timestamps
    end
  end
end
