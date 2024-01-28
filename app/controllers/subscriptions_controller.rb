class Api::V0::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)

    if subscription.save
      # Associate the subscription with customers
      customer_ids = params[:subscription][:customer_ids]
      subscription.customers << Customer.where(id: customer_ids) if customer_ids.present?

      render json: { status: 'success', message: 'Subscription created successfully' }, status: :created
    else
      render json: { status: 'error', message: 'Subscription creation failed', errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def subscription_params
      params.require(:subscription).permit(:title, :price, :status, :frequency)
    end
  end
end