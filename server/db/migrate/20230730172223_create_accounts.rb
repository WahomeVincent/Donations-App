class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :image
      t.string :mobile
      t.string :email
      t.string :account_number
      t.references :user, null: true, foreign_key: true
      t.references :donor, null: true, foreign_key: true
      t.references :charity, null: true, foreign_key: true
      t.timestamps
    end
  end
end
