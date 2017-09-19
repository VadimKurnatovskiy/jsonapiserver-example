class CreatePatrons < ActiveRecord::Migration[5.1]
  def change
    create_table :patrons do |t|
      t.string :first_name, null: false, collation: 'NOCASE'
      t.string :last_name, null: false, collation: 'NOCASE'
      t.string :city, null: false, collation: 'NOCASE'
      t.timestamps
    end
    add_index :patrons, [:first_name, :last_name, :city], unique: true
  end
end
