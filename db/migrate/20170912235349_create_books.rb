class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.references :publisher, null: false
      t.references :author, null: false
      t.string :title, null: false, collation: 'NOCASE'
      t.string :description, collation: 'NOCASE'
      t.date :publication_date, null: false
      t.float :price, null: false
      t.timestamps
    end
    add_index :books, :title, unique: true
  end
end
