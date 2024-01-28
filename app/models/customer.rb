class Customer < ApplicationRecord
  has_many :subscriptions_customers
  has_many :subscriptions, through: :subscription_customers
end
