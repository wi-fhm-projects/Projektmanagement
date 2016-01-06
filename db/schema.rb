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

ActiveRecord::Schema.define(version: 20151224100817) do

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
    t.string   "name"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questionaries", ["project_id"], name: "index_questionaries_on_project_id"

  create_table "questions", force: :cascade do |t|
    t.string   "frage"
    t.integer  "response_average"
    t.integer  "questionary_id"
    t.integer  "workpackage_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
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
    t.string   "antwort"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "responses", ["question_id"], name: "index_responses_on_question_id"

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

  create_table "workpackages", force: :cascade do |t|
    t.string   "name"
    t.integer  "subtask_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "workpackages", ["subtask_id"], name: "index_workpackages_on_subtask_id"

end
