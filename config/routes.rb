Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      post "/subscriptions", to: "subscriptions#create"
      patch "/subscription_cancel", to: "subscriptions#cancel"

      get "/:customer_id/subs", to: "customers#show"
    end
  end
end
