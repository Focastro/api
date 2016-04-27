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

ActiveRecord::Schema.define(version: 20160427195055) do

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "status"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "id_user",     limit: 4
    t.string   "image",       limit: 255
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "username",      limit: 255
    t.string   "token",         limit: 255
    t.datetime "creation_date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "product_req_id",     limit: 4
    t.integer  "product_offered_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "status"
    t.integer  "user_prod_req",      limit: 4
    t.integer  "user_prod_offe",     limit: 4
    t.boolean  "active"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "password_digest", limit: 255
    t.string   "firstname",       limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
