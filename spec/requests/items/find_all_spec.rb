require 'rails_helper'

RSpec.describe "Api::V1::Items#Find", type: :request do
  describe 'GET /api/v1/items/find_all' do
    it 'returns items by name fragment' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", description: "Newest Iphone!")
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", description: "Even newer Iphone!")
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", description: "Better than the iphone!")
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , description: "Powered by microwaves")

      get "/api/v1/items/find_all", params: { name: "phon" }

      expect(response).to have_http_status(:success)

      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
        expect(item[:attributes][:name].downcase).to include("phon")
      end

      get "/api/v1/items/find_all", params: { name: "iph" }

      expect(response).to have_http_status(:success)

      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
        expect(item[:attributes][:name].downcase).to include("iph")
      end
    end

    it 'has sad path for no item found' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", description: "Newest Iphone!")
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", description: "Even newer Iphone!")
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", description: "Better than the iphone!")
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , description: "Powered by microwaves")

      get "/api/v1/items/find_all", params: { name: "NOMATCH" }

      expect(response).to have_http_status(:bad_request)
    end

    it 'has sad path for name empty string' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", description: "Newest Iphone!")
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", description: "Even newer Iphone!")
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", description: "Better than the iphone!")
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , description: "Powered by microwaves")

      get "/api/v1/items/find_all", params: { name: "" }

      expect(response).to have_http_status(:bad_request)
    end

    it 'can find item unit price by min max price' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", unit_price: 20.99)
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", unit_price: 9.99) 
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", unit_price: 200.15) 
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , unit_price: 75.50)

      get "/api/v1/items/find_all", params: { min_price: 10, max_price: 100 }
      
      expect(response).to have_http_status(:success)

      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
        expect(item[:attributes][:unit_price]).to be >= 10
        expect(item[:attributes][:unit_price]).to be <= 100
      end

      get "/api/v1/items/find_all", params: { min_price: 1, max_price: 300 }

      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
        expect(item[:attributes][:unit_price]).to be >= 1
        expect(item[:attributes][:unit_price]).to be <= 300
      end
    end

    it 'can find item by either min or max price' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", unit_price: 20.99)
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", unit_price: 9.99) 
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", unit_price: 200.15) 
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , unit_price: 75.50)

      get "/api/v1/items/find_all", params: { min_price: 10 }

      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
        expect(item[:attributes][:unit_price]).to be >= 10
      end

      get "/api/v1/items/find_all", params: { max_price: 50 }

      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
        expect(item[:attributes][:unit_price]).to be <= 50
      end
    end

    it 'has sad path for name and price search' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", unit_price: 20.99)
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", unit_price: 9.99) 
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", unit_price: 200.15) 
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , unit_price: 75.50)

      get "/api/v1/items/find_all", params: { min_price: 10, name: "phone" }

      expect(response).to have_http_status(:bad_request)

      get "/api/v1/items/find_all", params: { min_price: 10, max_price: 100, name: "phone" }

      expect(response).to have_http_status(:bad_request)
    end

    it 'has sad path for negative price search' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", unit_price: 20.99)
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", unit_price: 9.99) 
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", unit_price: 200.15) 
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , unit_price: 75.50)

      get "/api/v1/items/find_all", params: { min_price: -10, max_price: -100}

      expect(response).to have_http_status(:bad_request)

      get "/api/v1/items/find_all", params: { min_price: 20, max_price: -75}

      expect(response).to have_http_status(:bad_request)

      get "/api/v1/items/find_all", params: { min_price: -15, max_price: 125}

      expect(response).to have_http_status(:bad_request)

      get "/api/v1/items/find_all", params: { min_price: -1}

      expect(response).to have_http_status(:bad_request)

      get "/api/v1/items/find_all", params: { max_price: -80}

      expect(response).to have_http_status(:bad_request)
    end
  end
end