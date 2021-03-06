# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160425141838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicant_skills", force: :cascade do |t|
    t.integer  "applicant_id"
    t.integer  "skill_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "applicant_skills", ["applicant_id", "skill_id"], name: "index_applicant_skills_on_applicant_id_and_skill_id", unique: true, using: :btree
  add_index "applicant_skills", ["applicant_id"], name: "index_applicant_skills_on_applicant_id", using: :btree
  add_index "applicant_skills", ["skill_id"], name: "index_applicant_skills_on_skill_id", using: :btree

  create_table "applicants", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "contact",         null: false
    t.boolean  "active",          null: false
    t.decimal  "expected_salary", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true, using: :btree

  create_table "vacancies", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "validity_days", null: false
    t.decimal  "salary",        null: false
    t.text     "contacts",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "vacancy_skills", force: :cascade do |t|
    t.integer  "vacancy_id", null: false
    t.integer  "skill_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vacancy_skills", ["skill_id"], name: "index_vacancy_skills_on_skill_id", using: :btree
  add_index "vacancy_skills", ["vacancy_id", "skill_id"], name: "index_vacancy_skills_on_vacancy_id_and_skill_id", unique: true, using: :btree
  add_index "vacancy_skills", ["vacancy_id"], name: "index_vacancy_skills_on_vacancy_id", using: :btree

  add_foreign_key "applicant_skills", "applicants"
  add_foreign_key "applicant_skills", "skills"
  add_foreign_key "vacancy_skills", "skills"
  add_foreign_key "vacancy_skills", "vacancies"
end
