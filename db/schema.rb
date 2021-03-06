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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140830055932) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "client_lists", :force => true do |t|
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "employees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "employee_code"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "code"
    t.integer  "client_list_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "sheets", :force => true do |t|
    t.integer  "client_list_id"
    t.integer  "project_id"
    t.integer  "activity_id"
    t.string   "task"
    t.datetime "date"
    t.datetime "in_time"
    t.datetime "out_time"
    t.string   "remarks"
    t.integer  "employee_id"
    t.string   "status"
    t.string   "comments"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "tasksheets", :force => true do |t|
    t.integer  "client_list_id"
    t.integer  "project_id"
    t.integer  "activity_id"
    t.string   "task"
    t.datetime "date"
    t.datetime "in_time"
    t.datetime "out_time"
    t.string   "remarks"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "employee_id"
    t.integer  "flag"
    t.string   "comments"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username",               :default => ""
    t.integer  "employee_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
