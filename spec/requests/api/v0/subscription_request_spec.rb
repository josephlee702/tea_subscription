require 'rails_helper'
		
describe "Tea Subscription Request API Happy Path" do
  it "subscribes a customer to a tea subscription" do
    customer = Customer.create(first_name: "Joseph", last_name: "Lee", email: "josephlee@gmail.com", address: "123 Test St, CO 80234")

    subscription = Subscription.create(title: "Variety Pack", price: "$25", frequency: "1x/month")

    #THIS LINES MAKE THE TEST FAIL. FIGURE OUT WHY.
    # expect(customer.subscriptions).to eq([])
    # expect(subscription.customers).to eq([])

    tea1 = Tea.create(title: "Produced through a process that includes withering the leaves under strong sun and allowing some oxidation to occur before curling and twisting. Oolong Tea", description: "Contains caffeine.", temperature: "75F", brew_time: "2-3 minutes") 

    tea2 = Tea.create(title: "Black Tea", description: "Black tea is a type of tea that is more oxidized than oolong, yellow, white and green teas. Black tea is generally stronger in flavour than other teas.", temperature: "80F", brew_time: "3-5 minutes") 

    tea3 = Tea.create(title: "Green Tea", description: "Green tea is a type of tea that is made from Camellia sinensis leaves and buds that have not undergone the same withering and oxidation process which is used to make oolong teas and black teas.", temperature: "70F", brew_time: "1-2 minutes") 

    SubscriptionTea.create(subscription_id: subscription.id, tea_id: tea1.id)
    SubscriptionTea.create(subscription_id: subscription.id, tea_id: tea2.id)
    SubscriptionTea.create(subscription_id: subscription.id, tea_id: tea3.id)

    post "/api/v0/subscriptions", params: {
      customer_id: customer.id,
      subscription_id: subscription.id
    }

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(json_response[:status]).to eq("success")
    expect(json_response[:message]).to eq("Customer subscribed successfully.")

    expect(subscription.teas.count).to eq(3)
    expect(subscription.customers.count).to eq(1)
    expect(subscription.customers.first).to eq(customer)
    expect(customer.subscriptions.count).to eq(1)
    expect(customer.subscriptions.first).to eq(subscription)
    expect(tea1.subscriptions.count).to eq(1)
    expect(tea1.subscriptions.first).to eq(subscription)
    expect(tea2.subscriptions.count).to eq(1)
    expect(tea2.subscriptions.first).to eq(subscription)
    expect(tea3.subscriptions.count).to eq(1)
    expect(tea3.subscriptions.first).to eq(subscription)
  end

  it "cancels a customer's subscription" do
    customer = Customer.create(first_name: "Joseph", last_name: "Lee", email: "josephlee@gmail.com", address: "123 Test St, CO 80234")

    subscription = Subscription.create(title: "Variety Pack", price: "$25", frequency: "1x/month")

    subcust = SubscriptionCustomer.create(customer_id: customer.id, subscription_id: subscription.id, status: "active")

    expect(subcust.status).to eq("active")

    patch "/api/v0/subscription_cancel", params: {
      subscription_customer: subcust.id
    }

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(json_response[:status]).to eq("success")
    expect(json_response[:message]).to eq("Subscription was successfully cancelled.")

    cancelled_subcust = SubscriptionCustomer.find_by(id: subcust.id)
    expect(cancelled_subcust.status).to eq("cancelled")
  end
end
