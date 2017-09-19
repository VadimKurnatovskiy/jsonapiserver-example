class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false, collation: 'NOCASE'
      t.string :middle_name, collation: 'NOCASE'
      t.string :last_name, null: false, collation: 'NOCASE'
      t.string :description, collation: 'NOCASE'
      t.integer :year_of_birth
      t.timestamps
    end
    add_index :authors, [:first_name, :last_name], unique: true
  end
end
