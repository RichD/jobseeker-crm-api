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

ActiveRecord::Schema[8.0].define(version: 2025_11_29_044758) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "job_skills", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "skill_id", null: false
    t.integer "years_required"
    t.string "classification", default: "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id", "skill_id"], name: "index_job_skills_on_job_id_and_skill_id", unique: true
    t.index ["job_id"], name: "index_job_skills_on_job_id"
    t.index ["skill_id"], name: "index_job_skills_on_skill_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "company"
    t.string "url"
    t.string "location"
    t.integer "status"
    t.text "description"
    t.text "notes"
    t.string "compensation"
    t.datetime "applied_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "status"], name: "index_jobs_on_user_id_and_status"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "aliases", default: [], array: true
    t.string "category"
    t.integer "popularity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aliases"], name: "index_skills_on_aliases", using: :gin
    t.index ["slug"], name: "index_skills_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "job_skills", "jobs"
  add_foreign_key "job_skills", "skills"
  add_foreign_key "jobs", "users"
end
