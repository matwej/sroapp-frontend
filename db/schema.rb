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

ActiveRecord::Schema.define(version: 20140614193516) do

  create_table "opandsros", force: true do |t|
    t.integer  "sro_id"
    t.integer  "operation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operations", force: true do |t|
    t.text     "popis"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "t_pred"
    t.string   "meno"
    t.string   "priez"
    t.string   "t_za"
    t.string   "ulica"
    t.integer  "cislo"
    t.string   "obec"
    t.integer  "psc"
    t.string   "stat"
    t.integer  "typ"
    t.date     "dat_nar"
    t.string   "rc"
    t.integer  "vklad"
    t.integer  "splatene"
    t.text     "sposob"
    t.date     "funkcia_od"
    t.integer  "sro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "meno"
    t.string   "priez"
    t.string   "t_pred"
    t.string   "t_za"
    t.string   "ulica"
    t.integer  "cislo"
    t.string   "obec"
    t.integer  "psc"
    t.string   "stat"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sros", force: true do |t|
    t.string   "nazov"
    t.string   "ulica"
    t.integer  "cislo"
    t.string   "obec"
    t.integer  "psc"
    t.string   "stat"
    t.string   "ico"
    t.string   "forma"
    t.integer  "imanie"
    t.integer  "splatene"
    t.string   "proces"
    t.boolean  "schvalene"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "encpass"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zips", force: true do |t|
    t.string   "file"
    t.integer  "sro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
