class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.decimal :amount
      t.references :donor, null: false, foreign_key: true
      t.references :charity, null: false, foreign_key: true
      t.boolean :repeat_donation, default: false
      t.boolean :anonymous, default: false
      t.timestamps
    end
  end
end
