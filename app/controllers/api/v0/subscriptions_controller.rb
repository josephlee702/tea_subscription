class Api::V0::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.find_by(id: params[:subscription_id])
    customer = Customer.find_by(customer_id: params[:customer_id])

    new_subscription_customer = SubscriptionCustomer.create(subscription_id: subscription.id, customer_id: customer.id)
  end
end