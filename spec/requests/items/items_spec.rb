require 'rails_helper'

RSpec.describe "Api::V1::Items", type: :request do
  describe "GET /index" do
    it "returns http success" do
      merchant = create(:merchant)
      create_list(:item, 10, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to have_http_status(:success)
    end
    
    it 'returns all merchant items' do
      merchant = create(:merchant)
      create_list(:item, 10, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a(Array)
      expect(items[:data].count).to eq(10)
    end
  end
end
