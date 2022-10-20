require 'rails_helper'

RSpec.describe "Api::V1::Merchants#Show", type: :request do
  describe "GET /show" do
    it 'displays one merchant record successfully' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      get "/api/v1/merchants/#{merchant_1.id}"

      expect(response).to be_successful

      get "/api/v1/merchants/#{merchant_2.id}"

      expect(response).to be_successful
    end

    it 'shows attributes' do
      merchant_1 = create(:merchant)

      get "/api/v1/merchants/#{merchant_1.id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to be_a(Hash)
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a(Hash)
      expect(merchant[:data][:id]).to be_a(String)
      expect(merchant[:data][:type]).to eq('merchant')
      expect(merchant[:data][:attributes]).to be_a(Hash)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    it 'has sad path if merchant id cannot be found' do
      get "/api/v1/merchants/9000" 

      expect(response).to have_http_status(:not_found) 
    end

    it 'shows merchant associated with item' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to have_http_status(:success)

      merchant_data = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_data[:data][:id].to_i).to eq(merchant.id)
    end
  end
end