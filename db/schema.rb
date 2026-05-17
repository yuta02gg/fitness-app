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

ActiveRecord::Schema[7.2].define(version: 2026_05_17_123619) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "body_part", null: false
    t.text "memo"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_exercises_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "training_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "trained_on", null: false
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "trained_on"], name: "index_training_records_on_user_id_and_trained_on", unique: true
    t.index ["user_id"], name: "index_training_records_on_user_id"
  end

  create_table "training_sets", force: :cascade do |t|
    t.bigint "training_record_id", null: false
    t.bigint "exercise_id", null: false
    t.integer "set_number", null: false
    t.decimal "weight", precision: 5, scale: 2, null: false
    t.integer "reps", null: false
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_training_sets_on_exercise_id"
    t.index ["training_record_id", "exercise_id", "set_number"], name: "idx_on_training_record_id_exercise_id_set_number_2a2d895b9f"
    t.index ["training_record_id"], name: "index_training_sets_on_training_record_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
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

  add_foreign_key "exercises", "users"
  add_foreign_key "training_records", "users"
  add_foreign_key "training_sets", "exercises"
  add_foreign_key "training_sets", "training_records"
end
