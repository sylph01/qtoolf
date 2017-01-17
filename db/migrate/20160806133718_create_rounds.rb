class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.integer :event_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
