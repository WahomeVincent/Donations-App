class CreateBeneficiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :beneficiaries do |t|
      t.string :name
      t.string :image
      t.text :description
      t.string :email
      t.string :phonenumber
      t.references :charity, null: true, foreign_key: true
      t.references :donor, null: true, foreign_key: true
      t.timestamps
    end
  end
end
