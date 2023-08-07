class CreateAdministrators < ActiveRecord::Migration[7.0]
  def change
    create_table :administrators do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.timestamps
    end
  end
end
