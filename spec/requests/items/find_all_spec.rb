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

      expect(response).to have_http_status(:not_found)
    end
  end
end