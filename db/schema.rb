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

ActiveRecord::Schema[7.0].define(version: 2023_07_18_151919) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "breeds", force: :cascade do |t|
    t.string "name"
    t.integer "good_with_children"
    t.integer "good_with_other_dogs"
    t.integer "shedding"
    t.integer "grooming"
    t.integer "drooling"
    t.integer "coat_length"
    t.integer "good_with_strangers"
    t.integer "playfulness"
    t.integer "protectiveness"
    t.integer "trainability"
    t.integer "energy"
    t.integer "barking"
    t.integer "min_life_expectancy"
    t.integer "max_life_expectancy"
    t.integer "max_height_male"
    t.integer "max_height_female"
    t.integer "max_weight_male"
    t.integer "max_weight_female"
    t.integer "min_height_male"
    t.integer "min_height_female"
    t.integer "min_weight_male"
    t.integer "min_weight_female"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.integer "age"
    t.boolean "neutered"
    t.boolean "vaccinated"
    t.string "address"
    t.text "bio"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "breed_id"
    t.index ["breed_id"], name: "index_dogs_on_breed_id"
    t.index ["owner_id"], name: "index_dogs_on_owner_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "status", default: "undecided"
    t.bigint "from_owner_id", null: false
    t.bigint "to_owner_id", null: false
    t.string "from_owner_decision"
    t.string "to_owner_decision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_owner_id"], name: "index_matches_on_from_owner_id"
    t.index ["to_owner_id"], name: "index_matches_on_to_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.text "bio"
    t.string "wechat_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "dogs", "breeds"
  add_foreign_key "dogs", "owners"
  add_foreign_key "matches", "owners", column: "from_owner_id"
  add_foreign_key "matches", "owners", column: "to_owner_id"
end
