require 'rails_helper'

RSpec.describe "Api::V1::Items#Index", type: :request do
  describe "GET /index" do
    it "returns http success" do
      merchant = create(:merchant)
      create_list(:item, 10, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to have_http_status(:success)
    end
    
    it 'returns all merchant items for given merchant' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      create_list(:item, 10, merchant: merchant_1)
      create_list(:item, 5, merchant: merchant_2)

      get "/api/v1/merchants/#{merchant_1.id}/items"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to eq(10)

      get "/api/v1/merchants/#{merchant_2.id}/items"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(5)
    end

    it 'returns all items' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      create_list(:item, 10, merchant: merchant_1)
  
      get "/api/v1/items"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to eq(10)

      create_list(:item, 5, merchant: merchant_2)

      get "/api/v1/items"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(15)
    end

    it 'has sad path for no items' do
      get "/api/v1/items"

      expect(response).to have_http_status(:not_found)
    end
  end
end
