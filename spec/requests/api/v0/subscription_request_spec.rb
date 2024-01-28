require 'rails_helper'
		
describe "Subscription Request API Happy Path", :vcr do
  it "subscribes a customer to a tea subscription" do
    customer = Customer.create(name: "Joseph Lee", email: "josephlee@gmail.com")

    get "/api/v0/subscribe"
    
    require 'pry'; binding.pry

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end