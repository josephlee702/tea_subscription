class SubscriptionService
  def self.create_subscription(subscription_id, customer_id)
    new_subscription_customer = SubscriptionCustomer.create(subscription_id: subscription_id, customer_id: customer_id, status: "active")
  end

  def self.cancel_subscription(subscription_customer_id)
    record = SubscriptionCustomer.find_by(id: subscription_customer_id)

    if record && record.status == "active"
      record.update(status: "cancelled")
      SubscriptionCustomer.find_by(id: subscription_customer_id)
    elsif record && record.status = "cancelled"
      "Already cancelled"
    else
    end
  end

  def self.see_all_subscriptions

  end
end