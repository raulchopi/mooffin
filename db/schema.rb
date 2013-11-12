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

ActiveRecord::Schema.define(version: 20131030140053) do

  create_table "authorizations", force: true do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "recipe_id",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", force: true do |t|
    t.integer  "recipe_id",     null: false
    t.integer  "ingredient_id", null: false
    t.integer  "importance",    null: false
    t.integer  "unit_id",       null: false
    t.float    "number",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opinions", force: true do |t|
    t.integer  "recipe_id",  null: false
    t.integer  "user_id",    null: false
    t.float    "rating",     null: false
    t.text     "opinion",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.integer  "user_id",     null: false
    t.string   "title",       null: false
    t.integer  "difficulty",  null: false
    t.integer  "time",        null: false
    t.integer  "servings",    null: false
    t.text     "description", null: false
    t.float    "rating",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", force: true do |t|
    t.integer  "recipe_id",   null: false
    t.integer  "order",       null: false
    t.integer  "time",        null: false
    t.text     "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", force: true do |t|
    t.string   "unit",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",               null: false
    t.string   "surname",            null: false
    t.string   "username",           null: false
    t.string   "email",              null: false
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
