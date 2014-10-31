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

ActiveRecord::Schema.define(version: 20141025212331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: true do |t|
    t.string  "name"
    t.string  "cuisine"
    t.float   "price"
    t.string  "allergens"
    t.integer "spicy_level"
  end

  create_table "orders", force: true do |t|
    t.integer "food_id"
    t.integer "party_id"
  end

  create_table "parties", force: true do |t|
    t.integer "table_number"
    t.integer "guests"
    t.boolean "pay_status"
    t.string  "surname"
  end

  create_table "users", force: true do |t|
    t.string   "username",      null: false
    t.string   "phone",         null: false
    t.string   "email",         null: false
    t.string   "password_hash", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end