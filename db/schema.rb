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

ActiveRecord::Schema.define(:version => 20110523084132) do

  create_table "classifications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifications_periods", :id => false, :force => true do |t|
    t.integer "classification_id"
    t.integer "period_id"
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.date     "date"
    t.string   "description"
    t.string   "medium_id"
    t.string   "classification_id"
    t.float    "physical_width"
    t.float    "physical_height"
    t.float    "physical_depth"
    t.integer  "file_width"
    t.integer  "file_height"
    t.string   "tags"
    t.string   "keywords"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_path"
    t.string   "thumbnail_path"
    t.integer  "period_id"
  end

  create_table "media", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periods", :force => true do |t|
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
