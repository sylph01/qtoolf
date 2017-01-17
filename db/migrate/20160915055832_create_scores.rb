class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :match_id
      t.integer :order
      t.string :name
      t.string :genre
      t.string :kind
      t.string :score
      t.string :note

      t.timestamps
    end
  end
end
