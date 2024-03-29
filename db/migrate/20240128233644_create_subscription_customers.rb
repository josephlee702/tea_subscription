class CreateSubscriptionCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :subscription_customers do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.string :status, default: "active"

      t.timestamps
    end
  end
end
