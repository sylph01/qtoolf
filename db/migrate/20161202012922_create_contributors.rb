class CreateContributors < ActiveRecord::Migration[5.0]
  def change
    create_table :contributors do |t|
      t.integer :event_id
      t.string :screen_name

      t.timestamps
    end
  end
end
