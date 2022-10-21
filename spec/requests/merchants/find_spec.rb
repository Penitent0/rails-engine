require 'rails_helper'

RSpec.describe "Api::V1::Merchants#Find", type: :request do
  describe 'GET /api/v1/merchants/find' do
    it 'returns one merchant by name fragment' do
      merchant_1 = create(:merchant, name: "Steve")
      merchant_2 = create(:merchant, name: "Bob")
      merchant_3 = create(:merchant, name: "Larry")
      merchant_4 = create(:merchant, name: "Mark")

      get "/api/v1/merchants/find", params: { name: "ark" }

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data][:attributes][:name]).to include("ark")
      expect(merchant[:data][:id].to_i).to eq(merchant_4.id)
    end

    it 'returns first match by alphabetical order' do
      merchant_1 = create(:merchant, name: "Barry")
      merchant_2 = create(:merchant, name: "Larry")
      merchant_3 = create(:merchant, name: "Mary")
      merchant_4 = create(:merchant, name: "Harry")

      get "/api/v1/merchants/find", params: { name: "arr" }

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data][:attributes][:name]).to include("arr")
      expect(merchant[:data][:id].to_i).to eq(merchant_1.id)
    end

    it 'has sad path for no merchant found' do
      merchant_1 = create(:merchant, name: "Steve")
      merchant_2 = create(:merchant, name: "Bob")
      merchant_3 = create(:merchant, name: "Larry")
      merchant_4 = create(:merchant, name: "Mark")

      get "/api/v1/merchants/find", params: { name: "NOMATCH" }

      expect(response).to have_http_status(:not_found)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:error]).to include("NOMATCH")
    end

    it 'has sad path for no merchant match found' do
      merchant_1 = create(:merchant, name: "Steve")
      merchant_2 = create(:merchant, name: "Bob")
      merchant_3 = create(:merchant, name: "Larry")
      merchant_4 = create(:merchant, name: "Mark")

      get "/api/v1/merchants/find", params: { name: "" }

      expect(response).to have_http_status(:bad_request)
    end

    it 'has sad path for no merchant found' do
      get "/api/v1/merchants/find", params: { name: "something" }

      expect(response).to have_http_status(:not_found)
    end
  end
end