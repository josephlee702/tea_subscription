Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      #An endpoint to subscribe a customer to a tea subscription
      get "/subscribe", to: "subscription#subscribe"
      #An endpoint to cancel a customer’s tea subscription
      #An endpoint to see all of a customer’s subsciptions (active and cancelled)
    end
  end
end
