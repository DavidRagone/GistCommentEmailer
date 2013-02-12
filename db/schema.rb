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

ActiveRecord::Schema.define(:version => 20130211045855) do

  create_table "gists", :force => true do |t|
    t.string   "html_url"
    t.string   "description"
    t.datetime "github_created_at"
    t.datetime "github_updated_at"
    t.integer  "comments"
    t.boolean  "public"
    t.string   "comments_url"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "github_id"
    t.integer  "github_user_id"
    t.integer  "new_comments"
  end

  add_index "gists", ["comments"], :name => "index_gists_on_comments"
  add_index "gists", ["github_id"], :name => "index_gists_on_github_id"
  add_index "gists", ["public"], :name => "index_gists_on_public"

  create_table "github_users", :force => true do |t|
    t.string   "uid"
    t.string   "email"
    t.string   "oauth_token"
    t.string   "remember_token"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "name"
    t.string   "gravatar"
    t.boolean  "include_private_gists", :default => true
    t.boolean  "active",                :default => true
    t.boolean  "has_new_comments",      :default => false
  end

  add_index "github_users", ["oauth_token"], :name => "index_github_users_on_oauth_token"
  add_index "github_users", ["uid"], :name => "index_github_users_on_uid"

end
