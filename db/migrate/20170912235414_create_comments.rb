class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :book, null: false
      t.references :patron, null: false
      t.string :text, null: false, collation: 'NOCASE'
      t.timestamps
    end
    add_index :comments, [:patron_id, :text], unique: true
  end
end
