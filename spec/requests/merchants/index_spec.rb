require 'rails_helper'

RSpec.describe "Api::V1::Merchants", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/merchants/index"
      expect(response).to be_successful
    end

    it 'returns all merchants' do
      create_list(:merchant, 5)
      get "/api/v1/merchants"

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a(Hash)
      expect(merchants).to have_key(:data)
      expect(merchants[:data]).to be_a(Array)
      expect(merchants[:data].count).to eq(5)
    end

    it 'merchants has attributes' do
      create_list(:merchant, 5)
      get "/api/v1/merchants"

      merchants = JSON.parse(response.body, symbolize_names: true)
      
      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:attributes)
      end
    end

    it 'merchants has id as integer' do
      create_list(:merchant, 5)
      get "/api/v1/merchants"

      merchants = JSON.parse(response.body, symbolize_names: true)
      
      merchants[:data].each do |merchant|
        expect(merchant[:id]).to be_a(String)
      end
    end


    it 'merchants has name as string' do
      create_list(:merchant, 5)
      get "/api/v1/merchants"

      merchants = JSON.parse(response.body, symbolize_names: true)
      
      merchants[:data].each do |merchant|
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
  end
end
