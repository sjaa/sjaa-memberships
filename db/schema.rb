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

ActiveRecord::Schema[7.1].define(version: 2025_01_17_153554) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "admins_permissions", id: false, force: :cascade do |t|
    t.integer "admin_id", null: false
    t.integer "permission_id", null: false
    t.index ["admin_id", "permission_id"], name: "index_admins_permissions_on_admin_id_and_permission_id"
    t.index ["permission_id", "admin_id"], name: "index_admins_permissions_on_permission_id_and_admin_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.integer "bearer_id", null: false
    t.string "bearer_type", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bearer_id", "bearer_type"], name: "index_api_keys_on_bearer_id_and_bearer_type"
    t.index ["token"], name: "index_api_keys_on_token", unique: true
  end

  create_table "astrobins", force: :cascade do |t|
    t.string "username"
    t.integer "latest_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "address"
    t.integer "city_id"
    t.integer "state_id"
    t.string "zipcode"
    t.string "phone"
    t.string "email"
    t.boolean "primary"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_contacts_on_person_id"
  end

  create_table "donation_items", force: :cascade do |t|
    t.integer "donation_id"
    t.integer "equipment_id"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donation_id"], name: "index_donation_items_on_donation_id"
    t.index ["equipment_id"], name: "index_donation_items_on_equipment_id"
  end

  create_table "donation_phases", force: :cascade do |t|
    t.string "name"
    t.integer "donation_item_id"
    t.integer "person_id"
    t.datetime "date"
    t.index ["donation_item_id"], name: "index_donation_phases_on_donation_item_id"
    t.index ["name"], name: "index_donation_phases_on_name"
    t.index ["person_id"], name: "index_donation_phases_on_person_id"
  end

  create_table "donations", force: :cascade do |t|
    t.string "note"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["person_id"], name: "index_donations_on_person_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.integer "instrument_id"
    t.string "note"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_equipment_on_instrument_id"
    t.index ["person_id"], name: "index_equipment_on_person_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_people", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "group_id", null: false
    t.index ["group_id", "person_id"], name: "index_groups_people_on_group_id_and_person_id"
    t.index ["person_id", "group_id"], name: "index_groups_people_on_person_id_and_group_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "model"
    t.index ["kind"], name: "index_instruments_on_kind"
  end

  create_table "interests", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interests_people", id: false, force: :cascade do |t|
    t.integer "interest_id", null: false
    t.integer "person_id", null: false
    t.index ["interest_id", "person_id"], name: "index_interests_people_on_interest_id_and_person_id"
    t.index ["person_id", "interest_id"], name: "index_interests_people_on_person_id_and_interest_id"
  end

  create_table "membership_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "start"
    t.integer "term_months"
    t.boolean "ephemeris"
    t.boolean "new"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind_id"
    t.index ["kind_id"], name: "index_memberships_on_kind_id"
    t.index ["person_id"], name: "index_memberships_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "astrobin_id"
    t.string "notes"
    t.string "discord_id"
    t.integer "status_id"
    t.integer "referral_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name"], name: "index_people_on_first_name"
    t.index ["last_name"], name: "index_people_on_last_name"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_permissions_on_name"
  end

  create_table "referrals", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
