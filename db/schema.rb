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

ActiveRecord::Schema.define(version: 2018_08_19_171503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "train_searches", force: :cascade do |t|
    t.integer "first_seats_number"
    t.integer "second_seats_number"
    t.integer "third_seats_number"
    t.integer "uz_train_number", null: false
    t.string "uz_search_url"
    t.date "uz_departure", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uz_train_number"], name: "index_train_searches_on_uz_train_number"
  end

end
