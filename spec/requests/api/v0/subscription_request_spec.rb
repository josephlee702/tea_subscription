require 'rails_helper'
		
describe "Tea Subscription Request API Happy Path" do
  it "subscribes a customer to a tea subscription" do
    customer = Customer.create(first_name: "Joseph", last_name: "Lee", email: "josephlee@gmail.com", address: "123 Test St, CO 80234")

    subscription = Subscription.create(title: "Variety Pack", price: "$25", frequency: "1x/month")


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

    expect(response).to be_successful
    expect(response.status).to eq(201)
  end
end