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

ActiveRecord::Schema[7.0].define(version: 2023_09_20_002820) do
  create_table "answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.integer "option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "time", default: 0
    t.index ["option_id"], name: "index_answers_on_option_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "knowledges", force: :cascade do |t|
    t.integer "user_id"
    t.integer "topic_id"
    t.integer "level"
    t.integer "correct_answers_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_knowledges_on_topic_id"
    t.index ["user_id"], name: "index_knowledges_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.text "content"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "correct", default: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.integer "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level"
    t.index ["topic_id"], name: "index_questions_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_questions_L1"
    t.integer "amount_questions_L2"
    t.integer "amount_questions_L3"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "points", default: 0
    t.string "email"
    t.integer "streak", default: 0
  end

  add_foreign_key "answers", "options"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "knowledges", "topics"
  add_foreign_key "knowledges", "users"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "topics"
end
