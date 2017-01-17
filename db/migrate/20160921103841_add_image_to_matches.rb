class AddImageToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :image, :string
  end
end
