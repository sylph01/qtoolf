class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :owner_id
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
