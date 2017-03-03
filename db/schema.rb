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

ActiveRecord::Schema.define(version: 20170303073345) do
  create_table "assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "end_date"
    t.integer "group_id"
    t.integer "length"
    t.string "name"
    t.datetime "start_date"
    t.integer "test_id"
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_assignments_on_group_id"
    t.index ["test_id"], name: "index_assignments_on_test_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "attempts", default: 0, null: false
    t.datetime "created_at"
    t.datetime "failed_at"
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "locked_at"
    t.string "locked_by"
    t.integer "priority", default: 0, null: false
    t.string "queue"
    t.datetime "run_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "student_token"
    t.string "teacher_token"
    t.datetime "updated_at", null: false
    t.index ["student_token"], name: "index_groups_on_student_token"
    t.index ["teacher_token"], name: "index_groups_on_teacher_token"
  end

  create_table "matching_pair_answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "item1"
    t.string "item2"
    t.integer "question_id"
    t.integer "session_id"
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_matching_pair_answers_on_question_id"
    t.index ["session_id"], name: "index_matching_pair_answers_on_session_id"
  end

  create_table "matching_pairs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "item1"
    t.text "item2"
    t.integer "question_id"
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_matching_pairs_on_question_id"
  end

  create_table "members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "group_id"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "multiple_choice_answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "multiple_choice_option_id"
    t.integer "question_id"
    t.integer "session_id"
    t.datetime "updated_at", null: false
    t.index ["multiple_choice_option_id"], name: "index_multiple_choice_answers_on_multiple_choice_option_id"
    t.index ["question_id"], name: "index_multiple_choice_answers_on_question_id"
    t.index ["session_id"], name: "index_multiple_choice_answers_on_session_id"
  end

  create_table "multiple_choice_options", force: :cascade do |t|
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.integer "question_id"
    t.text "text"
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_multiple_choice_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "points"
    t.integer "question_type"
    t.integer "test_id"
    t.text "text"
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_questions_on_test_id"
  end

  create_table "scores", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "question_id"
    t.integer "score"
    t.integer "session_id"
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_scores_on_question_id"
    t.index ["session_id"], name: "index_scores_on_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "assignment_id"
    t.datetime "created_at", null: false
    t.datetime "start_time"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["assignment_id"], name: "index_sessions_on_assignment_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "text_answers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "question_id"
    t.integer "session_id"
    t.text "text"
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_text_answers_on_question_id"
    t.index ["session_id"], name: "index_text_answers_on_session_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "authentication_token", limit: 30
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "locked_at"
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end
end
