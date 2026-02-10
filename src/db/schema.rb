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

ActiveRecord::Schema[8.1].define(version: 2026_02_10_103857) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "custom_stadium_name"
    t.date "date", null: false
    t.integer "favorite_team_score"
    t.integer "home_away", null: false
    t.integer "opponent_score"
    t.bigint "opponent_team_id", null: false
    t.integer "result"
    t.bigint "stadium_id"
    t.string "starting_pitcher"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "video_url"
    t.index ["opponent_team_id"], name: "index_games_on_opponent_team_id"
    t.index ["stadium_id"], name: "index_games_on_stadium_id"
    t.index ["user_id", "date"], name: "index_games_on_user_id_and_date"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "stadiums", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "short_name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stadiums_on_name", unique: true
    t.index ["short_name"], name: "index_stadiums_on_short_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "short_name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
    t.index ["short_name"], name: "index_teams_on_short_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "crypted_password"
    t.string "email", null: false
    t.bigint "favorite_team_id", null: false
    t.string "name", null: false
    t.string "salt"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["favorite_team_id"], name: "index_users_on_favorite_team_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "games", "stadiums"
  add_foreign_key "games", "teams", column: "opponent_team_id"
  add_foreign_key "games", "users"
  add_foreign_key "users", "teams", column: "favorite_team_id"
end
