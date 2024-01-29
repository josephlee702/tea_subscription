class Api::V0::CustomersController < ApplicationController
  def show
    customer = Customer.find_by(id: params[:customer_id])
    render json: SubscriptionCustomer.where(customer_id: customer.id)
  end
end