Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      post "/subscriptions", to: "subscriptions#create"
      patch "/subscription_cancel", to: "subscriptions#cancel"
      #An endpoint to cancel a customer’s tea subscription

      #An endpoint to see all of a customer’s subsciptions (active and cancelled)
    end
  end
end
