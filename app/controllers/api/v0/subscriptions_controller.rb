class Api::V0::SubscriptionsController < ApplicationController
  def create
    new_subscription_customer = SubscriptionService.create_subscription(params[:subscription_id], params[:customer_id])

    if new_subscription_customer
      render json: { status: "success", message: "Customer subscribed successfully." }, status: 201
    else
      render json: { status: "failure", message: "Customer was not able to subscribe successfully." }, status: 400
    end
  end

  def cancel
    service_response = SubscriptionService.cancel_subscription(params[:subscription_customer])

    if service_response.status == "cancelled"
      render json: { status: "success", message: "Subscription was successfully cancelled." }, status: 200
    elsif service_response == "Already cancelled"
      render json: { status: "unsuccessful", message: "The subscription is already cancelled." }, status: 200
    else
      render json: {status: "unsuccessful", message: "The cancellation was not successful."}, status: 400
    end
  end
end