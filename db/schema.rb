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

ActiveRecord::Schema.define(version: 20160123213041) do

  create_table "beers", force: :cascade do |t|
    t.string   "name"
    t.integer  "brewery_id"
    t.string   "abv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "breweries", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "state_id"
    t.string   "city"
    t.string   "postal_code"
    t.string   "latitude"
    t.string   "longitude"
    t.boolean  "open_to_public"
    t.string   "description"
    t.string   "website"
    t.string   "established"
    t.string   "icon_image"
    t.string   "medium_image"
    t.string   "large_image"
    t.string   "square_medium_image"
    t.string   "square_large_image"
    t.string   "brewery_db_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.integer  "brewery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
