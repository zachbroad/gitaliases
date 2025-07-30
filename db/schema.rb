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

ActiveRecord::Schema[8.0].define(version: 2025_07_29_202314) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "aliases", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_aliases_on_user_id"
  end

  create_table "aliases_tags", id: false, force: :cascade do |t|
    t.integer "alias_id", null: false
    t.integer "tag_id", null: false
    t.index ["alias_id", "tag_id"], name: "index_aliases_tags_on_alias_id_and_tag_id", unique: true
    t.index ["tag_id", "alias_id"], name: "index_aliases_tags_on_tag_id_and_alias_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", default: "#6366f1"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "alias_id", null: false
    t.string "vote_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_address"
    t.index ["alias_id"], name: "index_votes_on_alias_id"
    t.index ["ip_address", "alias_id"], name: "index_votes_on_ip_address_and_alias_id", unique: true, where: "(user_id IS NULL)"
    t.index ["user_id", "alias_id"], name: "index_votes_on_user_id_and_alias_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "aliases", "users"
  add_foreign_key "votes", "aliases"
  add_foreign_key "votes", "users"
end
