require "rails_helper"

RSpec.describe "the customer subscriptions show" do
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

    get "/api/v0/#{customer.id}/subs"

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(customer.subscriptions.count).to eq(2)
    expect(customer.subscriptions).to eq([subscription1, subscription2])

    expect(parsed_json).to be_an(Array)
    expect(parsed_json.count).to eq(2)
    expect(parsed_json.first[:id]).to eq(subcust1.id)
    expect(parsed_json.first[:customer_id]).to eq(customer.id)
    expect(parsed_json.first[:subscription_id]).to eq(subscription1.id)
    expect(parsed_json.first[:status]).to eq("active")
    expect(parsed_json.second[:id]).to eq(subcust2.id)
    expect(parsed_json.second[:customer_id]).to eq(customer.id)
    expect(parsed_json.second[:subscription_id]).to eq(subscription2.id)
    expect(parsed_json.second[:status]).to eq("active")

    patch "/api/v0/subscription_cancel", params: {
      subscription_customer: subcust2.id
    }

    get "/api/v0/#{customer.id}/subs"

    parsed_json2 = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_json2).to be_an(Array)
    expect(parsed_json2.count).to eq(2)
    expect(parsed_json2.first[:id]).to eq(subcust1.id)
    expect(parsed_json2.first[:customer_id]).to eq(customer.id)
    expect(parsed_json2.first[:subscription_id]).to eq(subscription1.id)
    expect(parsed_json2.first[:status]).to eq("active")
    expect(parsed_json2.second[:id]).to eq(subcust2.id)
    expect(parsed_json2.second[:customer_id]).to eq(customer.id)
    expect(parsed_json2.second[:subscription_id]).to eq(subscription2.id)
    expect(parsed_json2.second[:status]).to eq("cancelled")
  end
end
