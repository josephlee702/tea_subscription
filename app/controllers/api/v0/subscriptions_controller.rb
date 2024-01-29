class Api::V0::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.find_by(id: params[:subscription_id])
    customer = Customer.find_by(id: params[:customer_id])

    new_subscription_customer = SubscriptionCustomer.create(subscription_id: subscription.id, customer_id: customer.id, status: "active")

    if new_subscription_customer
      render json: { status: "success", message: "Customer subscribed successfully." }, status: 201
    else
      render json: { status: "failure", message: "Customer was not able to subscribe successfully." }, status: 400
    end
  end

  def cancel
    record = SubscriptionCustomer.find_by(id: params[:subscription_customer])
    if record && record.status = "active"
      record.update(status: "cancelled")

      render json: { status: "success", message: "Subscription was successfully cancelled." }, status: 200
    elsif record && record.status = "cancelled"
      render json: { status: "unsuccessful", message: "The subscription is already cancelled." }, status: 200
    else
      render json: {status: "unsuccessful", message: "The cancellation was not successful."}, status: 400
    end
  end
end