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


ActiveRecord::Schema.define(version: 20170410193516) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "context"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
    t.integer  "county_id"
    t.float    "latitude"
    t.float    "longitude"
    t.index ["county_id"], name: "index_addresses_on_county_id", using: :btree
    t.index ["location_id"], name: "index_addresses_on_location_id", using: :btree
  end

  create_table "aliases", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "item_id"
    t.boolean  "active"
    t.index ["item_id"], name: "index_aliases_on_item_id", using: :btree
  end

  create_table "counties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "coordinator"
    t.string   "phone"
    t.string   "website"
  end

  create_table "item_counties", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "item_id"
    t.integer  "county_id"
    t.index ["county_id"], name: "index_item_counties_on_county_id", using: :btree
    t.index ["item_id"], name: "index_item_counties_on_item_id", using: :btree
  end

  create_table "item_locations", force: :cascade do |t|
    t.string   "description"
    t.date     "verified"
    t.text     "context"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "item_id"
    t.integer  "location_id"
    t.text     "reason"
    t.boolean  "active"
    t.index ["item_id"], name: "index_item_locations_on_item_id", using: :btree
    t.index ["location_id"], name: "index_item_locations_on_location_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"

    t.date     "verified"

  end

  add_foreign_key "addresses", "counties"
  add_foreign_key "addresses", "locations"
  add_foreign_key "aliases", "items"
  add_foreign_key "item_counties", "counties"
  add_foreign_key "item_counties", "items"
end
