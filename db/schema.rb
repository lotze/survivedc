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

ActiveRecord::Schema.define(:version => 20120518063747) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkins", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "checkpoint_id",  :null => false
    t.integer  "checkpoint_num", :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "user_agent",     :null => false
    t.string   "device_id"
    t.string   "ip_address",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "accuracy"
    t.string   "method"
  end

  add_index "checkins", ["user_id", "checkpoint_id"], :name => "index_checkins_on_user_id_and_checkpoint_id", :unique => true

  create_table "checkpoints", :force => true do |t|
    t.float    "longitude"
    t.float    "latitude"
    t.string   "street_address"
    t.string   "name"
    t.string   "secret_code"
    t.boolean  "is_mobile"
    t.boolean  "is_bonus"
    t.boolean  "is_finish"
    t.integer  "num_players",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkpoints", ["secret_code"], :name => "index_checkpoints_on_secret_code"

  create_table "friend_requests", :force => true do |t|
    t.integer  "requesting_id",                    :null => false
    t.integer  "target_id"
    t.string   "target_email",                     :null => false
    t.boolean  "approved",      :default => false, :null => false
    t.string   "code",                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_requests", ["code"], :name => "index_friend_requests_on_code", :unique => true
  add_index "friend_requests", ["requesting_id", "approved"], :name => "index_friend_requests_on_requesting_id_and_approved"
  add_index "friend_requests", ["requesting_id", "target_email"], :name => "index_friend_requests_on_requesting_id_and_target_email"

  create_table "location_updates", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "is_chaser"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "accuracy"
  end

  add_index "location_updates", ["created_at"], :name => "index_location_updates_on_created_at"
  add_index "location_updates", ["is_chaser", "created_at"], :name => "index_location_updates_on_is_chaser_and_created_at"
  add_index "location_updates", ["user_id", "created_at"], :name => "index_location_updates_on_user_id_and_created_at"

  create_table "progresses", :force => true do |t|
    t.integer  "checkpoint_num"
    t.integer  "num_people"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "progresses", ["checkpoint_num", "created_at"], :name => "index_progresses_on_checkpoint_num_and_created_at"

  create_table "tags", :force => true do |t|
    t.integer  "tagger_id"
    t.integer  "taggee_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street_address"
    t.string   "user_agent"
    t.string   "ip_address"
    t.string   "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tagger_id"], :name => "index_tags_on_tagger_id"

  create_table "users", :force => true do |t|
    t.string   "username",                                           :null => false
    t.string   "email",                                              :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.boolean  "is_chaser",                       :default => false, :null => false
    t.integer  "checkpoint_num",                  :default => 0,     :null => false
    t.datetime "last_checkpoint_at"
    t.integer  "onboarding_level",                :default => 0,     :null => false
    t.string   "photo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "team"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["checkpoint_num", "last_checkpoint_at"], :name => "index_users_on_checkpoint_num_and_last_checkpoint_at"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["is_chaser"], :name => "index_users_on_is_chaser"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["username"], :name => "index_users_on_username"

end
