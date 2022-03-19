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

ActiveRecord::Schema.define(version: 2022_03_19_110657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "collection_entries", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.jsonb "content", default: "{}", null: false
    t.integer "position", default: 0
    t.datetime "published_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["collection_id"], name: "index_collection_entries_on_collection_id"
    t.index ["content"], name: "index_collection_entries_on_content", using: :gin
    t.index ["discarded_at"], name: "index_collection_entries_on_discarded_at"
    t.index ["published_at"], name: "index_collection_entries_on_published_at"
  end

  create_table "collection_fields", force: :cascade do |t|
    t.string "label", null: false
    t.string "key", null: false
    t.bigint "collection_id", null: false
    t.integer "classification", default: 0, null: false
    t.boolean "required", default: false
    t.integer "position", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["collection_id"], name: "index_collection_fields_on_collection_id"
    t.index ["key", "collection_id"], name: "index_collection_fields_on_key_and_collection_id", unique: true
    t.index ["label", "collection_id"], name: "index_collection_fields_on_label_and_collection_id", unique: true
  end

  create_table "collections", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.bigint "site_id", null: false
    t.datetime "published_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_collections_on_discarded_at"
    t.index ["published_at"], name: "index_collections_on_published_at"
    t.index ["site_id"], name: "index_collections_on_site_id"
    t.index ["slug", "site_id"], name: "index_collections_on_slug_and_site_id", unique: true
  end

  create_table "contents", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.bigint "site_id", null: false
    t.text "body"
    t.datetime "published_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_contents_on_discarded_at"
    t.index ["published_at"], name: "index_contents_on_published_at"
    t.index ["site_id"], name: "index_contents_on_site_id"
    t.index ["slug", "site_id"], name: "index_contents_on_slug_and_site_id", unique: true
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "subdomain", null: false
    t.jsonb "settings", default: "{}", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discarded_at"], name: "index_sites_on_discarded_at"
    t.index ["name"], name: "index_sites_on_name", unique: true
    t.index ["settings"], name: "index_sites_on_settings", using: :gin
    t.index ["subdomain"], name: "index_sites_on_subdomain", unique: true
  end

  create_table "stores", force: :cascade do |t|
    t.string "storable_type"
    t.bigint "storable_id", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key", "storable_type", "storable_id"], name: "index_stores_on_key_and_storable_type_and_storable_id", unique: true
    t.index ["storable_type", "storable_id"], name: "index_stores_on_storable"
  end

  create_table "user_sites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "site_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id"], name: "index_user_sites_on_site_id"
    t.index ["user_id", "site_id"], name: "index_user_sites_on_user_id_and_site_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name"
    t.string "username", null: false
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
    t.jsonb "preferences", default: "{}", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["preferences"], name: "index_users_on_preferences", using: :gin
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object", default: "{}", null: false
    t.jsonb "object_changes", default: "{}", null: false
    t.datetime "created_at"
    t.string "origin"
    t.inet "ip"
    t.string "user_agent"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "collection_entries", "collections"
  add_foreign_key "collection_fields", "collections"
  add_foreign_key "collections", "sites"
  add_foreign_key "contents", "sites"
  add_foreign_key "user_sites", "sites"
  add_foreign_key "user_sites", "users"
end
