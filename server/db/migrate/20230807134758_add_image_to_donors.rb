class AddImageToDonors < ActiveRecord::Migration[7.0]
  def change
    add_column :donors, :image, :string
  end
end
