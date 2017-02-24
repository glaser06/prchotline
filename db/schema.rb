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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20170223061006) do
=======
ActiveRecord::Schema.define(version: 20170223232523) do
>>>>>>> f457293c802993d7ca1dca5bcf83fbbeb6304511

  create_table "counties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_counties", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "item_locations", force: :cascade do |t|
    t.string   "description"
    t.date     "verified"
    t.text     "context"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
<<<<<<< HEAD
=======
    t.integer  "item_id"
    t.integer  "location_id"
    t.text     "reason"
    t.index ["item_id"], name: "index_item_locations_on_item_id"
    t.index ["location_id"], name: "index_item_locations_on_location_id"
>>>>>>> f457293c802993d7ca1dca5bcf83fbbeb6304511
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
    t.string   "address"
    t.string   "phone"
    t.string   "website"
    t.string   "city"
    t.string   "zipcode"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
