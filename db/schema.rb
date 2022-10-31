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

ActiveRecord::Schema[7.0].define(version: 2022_08_10_054326) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "folder_post_relations", force: :cascade do |t|
    t.bigint "folder_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_folder_post_relations_on_folder_id"
    t.index ["post_id"], name: "index_folder_post_relations_on_post_id"
  end

  create_table "folders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "meta_infos", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.string "image"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_meta_infos_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "comment"
    t.string "url", null: false
    t.boolean "published", default: false
    t.integer "evaluation", default: 1
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.string "token"
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "folder_post_relations", "folders"
  add_foreign_key "folder_post_relations", "posts"
  add_foreign_key "folders", "users"
  add_foreign_key "meta_infos", "posts"
  add_foreign_key "posts", "users"
end
