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

ActiveRecord::Schema.define(:version => 20130107170031) do

  create_table "appointments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tech_id"
    t.integer  "review_id"
    t.string   "status"
    t.string   "description"
    t.datetime "appointment_time"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "roles", :force => true do |t|
    t.string "role"
  end

  create_table "user_roles", :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                                      :default => "",   :null => false
    t.string   "encrypted_password",           :limit => 128,                                :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                              :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                                                   :null => false
    t.datetime "updated_at",                                                                                   :null => false
    t.string   "username"
    t.string   "full_name"
    t.string   "bio"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.decimal  "lat",                                         :precision => 10, :scale => 7
    t.decimal  "lon",                                         :precision => 10, :scale => 7
    t.decimal  "distance",                                    :precision => 10, :scale => 0
    t.decimal  "rate",                                        :precision => 8,  :scale => 2
    t.string   "timezone"
    t.boolean  "active",                                                                     :default => true
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
