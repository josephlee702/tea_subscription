class Api::V0::CustomersController < ApplicationController
  def show
    customer = Customer.find_by(id: params[:customer_id])
    if customer.subscriptions == []
      render json: { status: 200, message: "Customer does not have any subscriptions." }, status: 200
    else
      render json: SubscriptionCustomer.where(customer_id: customer.id)
    end
  end
end