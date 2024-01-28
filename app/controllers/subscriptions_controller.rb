class Api::V0::SubscriptionsController < ApplicationController
  def subscribe
    render json: { status: 200 }, status: 200
  end
end