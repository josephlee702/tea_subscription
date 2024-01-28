require 'rails_helper'
		
describe "Tea Subscription Request API Happy Path" do
  it "subscribes a customer to a tea subscription" do
    customer = Customer.create(first_name: "Joseph", last_name: "Lee", email: "josephlee@gmail.com", address: "123 Test St, CO 80234")

    post "/api/v0/subscribe"

    require 'pry'; binding.pry

    expect(response).to be_successful
    expect(response.status).to eq(201)
  end
end