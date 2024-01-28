ActiveRecord::Schema[7.1].define(version: 2024_01_28_235841) do
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.string "price"
    t.string "status"
    t.string "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions_customers", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_subscriptions_customers_on_customer_id"
    t.index ["subscription_id"], name: "index_subscriptions_customers_on_subscription_id"
  end

  create_table "subscriptions_teas", force: :cascade do |t|
    t.bigint "tea_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_subscriptions_teas_on_subscription_id"
    t.index ["tea_id"], name: "index_subscriptions_teas_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "temperature"
    t.string "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subscriptions_customers", "customers"
  add_foreign_key "subscriptions_customers", "subscriptions"
  add_foreign_key "subscriptions_teas", "subscriptions"
  add_foreign_key "subscriptions_teas", "teas"
end
