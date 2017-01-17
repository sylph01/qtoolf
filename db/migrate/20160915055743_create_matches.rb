class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :court
      t.integer :number
      t.text :note
      t.integer :round_id

      t.timestamps
    end
  end
end
