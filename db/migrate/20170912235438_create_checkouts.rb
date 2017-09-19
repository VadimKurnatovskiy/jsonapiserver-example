class CreateCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :checkouts do |t|
      t.references :book, null: false
      t.references :patron, null: false
      t.date :checkout_date, null: false
      t.timestamps
    end
    add_index :checkouts, [:book_id, :checkout_date], unique: true
  end
end
