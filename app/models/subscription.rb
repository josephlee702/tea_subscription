class Subscription < ApplicationRecord
  has_many :subscriptions_customers
  has_many :subscriptions_teas
  has_many :customers, through: :subscriptions_customers
  has_many :teas, through: :subscriptions_teas
end
