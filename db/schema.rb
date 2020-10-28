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

ActiveRecord::Schema.define(version: 2020_10_26_092606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atms", force: :cascade do |t|
    t.string "currency_id"
    t.string "address"
    t.string "number_encrypted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commission_rules", force: :cascade do |t|
    t.integer "commission_type"
    t.float "rate"
    t.float "from_price"
    t.float "to_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", id: :string, force: :cascade do |t|
    t.string "symbol_icon", null: false
    t.boolean "is_base", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_base"], name: "index_currencies_on_is_base"
  end

  create_table "currency_converters", force: :cascade do |t|
    t.string "first_currency_id"
    t.string "second_currency_id"
    t.float "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "transaction_id"
    t.string "message"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_notifications_on_transaction_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "system_settings", force: :cascade do |t|
    t.string "country"
    t.string "country_short_code"
    t.integer "check_iban_number"
    t.string "name"
    t.integer "mfo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transaction_send_infos", force: :cascade do |t|
    t.bigint "transaction_id"
    t.integer "sender_id"
    t.string "sender_type"
    t.integer "recipient_id"
    t.string "recipient_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "operation", default: 0
    t.index ["transaction_id"], name: "index_transaction_send_infos_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "commission_rule_id"
    t.string "currency_id"
    t.integer "parent_id"
    t.string "operation_type"
    t.string "description"
    t.integer "status"
    t.float "amount"
    t.float "commission_amount"
    t.float "full_amount"
    t.json "currency_converters_info"
    t.json "commission_info"
    t.string "system_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_rule_id"], name: "index_transactions_on_commission_rule_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_wallets", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "wallet_id", null: false
    t.index ["user_id", "wallet_id"], name: "index_users_wallets_on_user_id_and_wallet_id"
    t.index ["wallet_id", "user_id"], name: "index_users_wallets_on_wallet_id_and_user_id"
  end

  create_table "wallet_availables", force: :cascade do |t|
    t.string "currency_id"
    t.date "expire_date"
    t.date "activated_at"
    t.string "number_encrypted"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_wallet_availables_on_currency_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "currency_id"
    t.string "type"
    t.string "description"
    t.date "expire_date"
    t.string "number_encrypted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
