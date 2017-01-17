class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :screen_name
      t.string :name
      t.boolean :admin

      t.timestamps
    end
  end
end
