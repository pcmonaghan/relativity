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

ActiveRecord::Schema.define(version: 20161230023951) do

  create_table "field_keys", force: :cascade do |t|
    t.string   "form_id"
    t.string   "subkey_num"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "subkey"
    t.string   "key_num"
  end

  create_table "forms", force: :cascade do |t|
    t.string   "integration"
    t.integer  "num_records"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "response_properties", force: :cascade do |t|
    t.string   "form_id"
    t.string   "key_num"
    t.string   "key"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "form_record_id"
    t.integer  "response_id"
    t.index ["response_id"], name: "index_response_properties_on_response_id"
  end

  create_table "response_subproperties", force: :cascade do |t|
    t.integer  "response_property_id"
    t.string   "subkey_num"
    t.string   "subkey"
    t.string   "value"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["response_property_id"], name: "index_response_subproperties_on_response_property_id"
  end

  create_table "responses", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "form_record_id"
    t.integer  "form_id"
    t.index ["form_id"], name: "index_responses_on_form_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
