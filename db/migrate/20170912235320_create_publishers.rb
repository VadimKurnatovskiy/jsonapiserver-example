class CreatePublishers < ActiveRecord::Migration[5.1]
  def change
    create_table :publishers do |t|
      t.string :name, null: false, collation: 'NOCASE'
      t.string :country, null: false, collation: 'NOCASE'
      t.timestamps
    end
    add_index :publishers, :name, unique: true
  end
end
