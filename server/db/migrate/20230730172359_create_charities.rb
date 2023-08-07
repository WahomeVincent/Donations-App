class CreateCharities < ActiveRecord::Migration[7.0]
  def change
    create_table :charities do |t|
      t.string :name
      t.string :image
      t.text :description
      t.string :email
      t.boolean :approved, default: false
      t.string :phonenumber
      t.references :administrator, null: false, foreign_key: true
      t.timestamps
    end
  end
end
