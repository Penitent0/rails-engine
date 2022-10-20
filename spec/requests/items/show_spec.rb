require 'rails_helper'

RSpec.describe "Api::V1::Items#Show", type: :request do
  describe "GET /show" do
    it "returns http success" do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      get "/api/v1/items/#{item.id}"

      expect(response).to have_http_status(:success)
    end

    it 'shows attributes for item' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      get "/api/v1/items/#{item.id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to be_a(Hash)
      expect(item).to have_key(:data)
      expect(item[:data]).to be_a(Hash)
      expect(item[:data][:id]).to be_a(String)
      expect(item[:data][:type]).to eq('item')
      expect(item[:data][:attributes]).to be_a(Hash)
      expect(item[:data][:attributes][:name]).to be_a(String)
    end

    it 'has sad path for item not found' do
      get "/api/v1/items/9000"

      expect(response).to have_http_status(:not_found)
    end
  end
end