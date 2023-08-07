# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_07_134758) do
  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "mobile"
    t.string "email"
    t.string "account_number"
    t.integer "user_id"
    t.integer "donor_id"
    t.integer "charity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charity_id"], name: "index_accounts_on_charity_id"
    t.index ["donor_id"], name: "index_accounts_on_donor_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "name"
    t.string "mobile"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "beneficiaries", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.text "description"
    t.string "email"
    t.string "phonenumber"
    t.integer "charity_id"
    t.integer "donor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charity_id"], name: "index_beneficiaries_on_charity_id"
    t.index ["donor_id"], name: "index_beneficiaries_on_donor_id"
  end

  create_table "charities", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.text "description"
    t.string "email"
    t.boolean "approved", default: false
    t.string "phonenumber"
    t.integer "administrator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id"], name: "index_charities_on_administrator_id"
  end

  create_table "donations", force: :cascade do |t|
    t.decimal "amount"
    t.integer "donor_id", null: false
    t.integer "charity_id", null: false
    t.boolean "repeat_donation", default: false
    t.boolean "anonymous", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charity_id"], name: "index_donations_on_charity_id"
    t.index ["donor_id"], name: "index_donations_on_donor_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_type"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "accounts", "charities"
  add_foreign_key "accounts", "donors"
  add_foreign_key "accounts", "users"
  add_foreign_key "beneficiaries", "charities"
  add_foreign_key "beneficiaries", "donors"
  add_foreign_key "charities", "administrators"
  add_foreign_key "donations", "charities"
  add_foreign_key "donations", "donors"
  add_foreign_key "roles", "users"
end
