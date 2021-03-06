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

ActiveRecord::Schema.define(version: 20160113161818) do

  create_table "allocationitems", force: :cascade do |t|
    t.integer  "workpackage_id"
    t.integer  "component_id"
    t.integer  "role_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "allocationitems", ["component_id"], name: "index_allocationitems_on_component_id"
  add_index "allocationitems", ["role_id"], name: "index_allocationitems_on_role_id"
  add_index "allocationitems", ["workpackage_id"], name: "index_allocationitems_on_workpackage_id"

  create_table "components", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "modul_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "components", ["modul_id"], name: "index_components_on_modul_id"

  create_table "kinds", force: :cascade do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kinds", ["project_id"], name: "index_kinds_on_project_id"

  create_table "moduls", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "subproduct_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "moduls", ["subproduct_id"], name: "index_moduls_on_subproduct_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questionaries", force: :cascade do |t|
    t.integer  "runde"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questionaries", ["project_id"], name: "index_questionaries_on_project_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "pessimistic_average"
    t.integer  "realistic_average"
    t.integer  "optimistic_average"
    t.integer  "questionary_id"
    t.integer  "workpackage_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "questions", ["questionary_id"], name: "index_questions_on_questionary_id"
  add_index "questions", ["workpackage_id"], name: "index_questions_on_workpackage_id"

  create_table "requirments", force: :cascade do |t|
    t.string   "qualifikation"
    t.string   "experience"
    t.integer  "role_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "requirments", ["role_id"], name: "index_requirments_on_role_id"

  create_table "responses", force: :cascade do |t|
    t.integer  "pessimistic"
    t.integer  "realistic"
    t.integer  "optimistic"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "responses", ["question_id"], name: "index_responses_on_question_id"
  add_index "responses", ["user_id"], name: "index_responses_on_user_id"

  create_table "roadmaps", force: :cascade do |t|
    t.string   "title"
    t.date     "start"
    t.integer  "project_id"
    t.integer  "questionary_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "roadmaps", ["project_id"], name: "index_roadmaps_on_project_id"
  add_index "roadmaps", ["questionary_id"], name: "index_roadmaps_on_questionary_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "kind_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["kind_id"], name: "index_roles_on_kind_id"

  create_table "subproducts", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subproducts", ["project_id"], name: "index_subproducts_on_project_id"

  create_table "subtasks", force: :cascade do |t|
    t.string   "name"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subtasks", ["task_id"], name: "index_subtasks_on_task_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id"

  create_table "userquests", force: :cascade do |t|
    t.boolean  "newquest",       default: true
    t.integer  "user_id"
    t.integer  "questionary_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "userquests", ["questionary_id"], name: "index_userquests_on_questionary_id"
  add_index "userquests", ["user_id"], name: "index_userquests_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "workpackages", force: :cascade do |t|
    t.string   "name"
    t.integer  "subtask_id"
    t.integer  "successor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "workpackages", ["subtask_id"], name: "index_workpackages_on_subtask_id"
  add_index "workpackages", ["successor_id"], name: "index_workpackages_on_successor_id"

  create_table "workpackages_workpackages", force: :cascade do |t|
    t.integer "workpackage_id"
    t.integer "successor_id"
  end

end
