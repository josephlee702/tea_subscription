require "rails_helper"

RSpec.describe "the customer index" do
  it "lists of a customer's active and cancelled subscriptions" do
    customer = Customer.create(first_name: "Joseph", last_name: "Lee", email: "josephlee@gmail.com", address: "123 Test St, CO 80234")
    subscription1 = Subscription.create(title: "Variety Pack", price: "$25", frequency: "1x/month")
    subscription2 = Subscription.create(title: "Green Tea Pack", price: "$20", frequency: "1x/month")
    subcust1 = SubscriptionCustomer.create(customer_id: customer.id, subscription_id: subscription1.id, status: "active")

    expect(customer.subscriptions.count).to eq(1)
    expect(customer.subscriptions.first.title).to eq("Variety Pack")
    expect(customer.subscriptions.first.price).to eq("$25")
    expect(customer.subscriptions.first.frequency).to eq("1x/month")
    
    subcust2 = SubscriptionCustomer.create(customer_id: customer.id, subscription_id: subscription2.id, status: "active")

    expect(customer.subscriptions.count).to eq(2)
    expect(customer.subscriptions.second.title).to eq("Green Tea Pack")
    expect(customer.subscriptions.second.price).to eq("$20")
    expect(customer.subscriptions.second.frequency).to eq("1x/month")

    expect(customer.subscriptions).to eq([subscription1, subscription2])

    subcust2.update(status: "cancelled")
    expect(subcust2.status).to eq("cancelled")

    expect(customer.subscriptions.count).to eq(2)
    expect(customer.subscriptions).to eq([subscription1, subscription2])
  end
end
