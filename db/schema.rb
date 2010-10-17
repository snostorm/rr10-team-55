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

ActiveRecord::Schema.define(:version => 20101017222847) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "locations", :force => true do |t|
    t.string   "city"
    t.string   "prov_or_state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "prov_or_state_name"
    t.string   "country_name"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    :default => false
    t.boolean  "recipient_deleted", :default => false
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postings", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.time     "date_expires"
    t.time     "date_closed"
    t.string   "location"
    t.boolean  "new"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category_id"
    t.integer  "user_id"
    t.integer  "location_id"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "requestor_id"
    t.integer  "poster_id"
    t.integer  "item_id"
    t.datetime "approved_by_poster_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "requestor_id"
    t.integer  "poster_id"
    t.integer  "item_id"
    t.datetime "approved_by_poster_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_moderator", :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.string   "location"
    t.string   "email"
    t.integer  "location_id"
  end

end
