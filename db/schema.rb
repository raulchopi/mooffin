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

ActiveRecord::Schema.define(version: 20130907134824) do

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opinions", force: true do |t|
    t.integer   "recipe_id"
    t.integer   "user_id"
    t.float     "rating"
    t.text      "opinion"
    t.datetime  "created_at"
    t.datetime  "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.integer   "user_id"
    t.string    "title"
    t.integer   "difficulty"
    t.integer   "time"
    t.integer   "servings"
    t.text      "description"
    t.float     "rating"
    t.datetime  "created_at"
    t.datetime  "updated_at"    
  end

  create_table "ingredients", force: true do |t|
    t.string    "name"
    t.integer   "importance"
  end

  create_table "steps", force: true do |t|
    t.integer   "recipe_id"
    t.integer   "order"
    t.integer   "time"
    t.text      "description"
  end

  create_table "likes", force: true do |t|
    t.integer   "recipe_id"
    t.integer   "user_id"
    t.datetime  "created_at"
  end

  create_table "links", force: true do |t|
    t.integer   "recipe_id"
    t.integer   "ingredient_id"
    t.integer   "unit_id"
    t.float     "number"
    
  end

  create_table "units", force: true do |t|
    t.string    "unit"
  end

end