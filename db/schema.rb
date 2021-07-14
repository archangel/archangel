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

ActiveRecord::Schema.define(version: 2021_07_09_225032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "metatags", force: :cascade do |t|
    t.string "metatagable_type"
    t.bigint "metatagable_id"
    t.string "name", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["metatagable_type", "metatagable_id"], name: "index_metatags_on_metatagable"
    t.index ["name", "metatagable_type", "metatagable_id"], name: "index_metatags_on_name_and_tagable_type_and_tagable_id", unique: true
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "site_id"
    t.string "title", default: "", null: false
    t.string "slug", default: "", null: false
    t.datetime "published_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_pages_on_discarded_at"
    t.index ["published_at"], name: "index_pages_on_published_at"
    t.index ["site_id"], name: "index_pages_on_site_id"
    t.index ["slug", "site_id"], name: "index_pages_on_slug_and_site_id", unique: true
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_sites_on_name", unique: true
    t.index ["token"], name: "index_sites_on_token", unique: true
  end

  create_table "user_sites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "site_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id"], name: "index_user_sites_on_site_id"
    t.index ["user_id", "site_id"], name: "index_user_sites_on_user_id_and_site_id"
    t.index ["user_id"], name: "index_user_sites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name"
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "auth_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "pages", "sites"
end
