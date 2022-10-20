require 'rails_helper'

RSpec.describe "Api::V1::Items#Update", type: :request do
  describe 'PATCH api/v1/item/:id' do
    let(:merchant) { create(:merchant) }
    let(:item) { create(:item, name: "Old Name", description: "100% old, busted item", unit_price: 11.50, merchant: merchant) }
    let(:update_item_params) do
      {
        merchant_id: merchant.id,
        item: {
        name: "Updated Item",
        description: "100% Authentic Updated Item",
        unit_price: 199.99,
        }
      }
    end

    let(:update_partial_item_params) do
      {
        merchant_id: merchant.id,
        item: {
        unit_price: 75.99
        }
      }
    end

    let(:update_wrong_item_params) do
      {
        merchant_id: merchant.id,
        item: {
        name: "",
        description: "",
        unit_price: "string"
        }
      }
    end

    let(:update_no_merchant_id) do
      {
        item: {
        name: "Test Name",
        description: "Test Description",
        unit_price: 100.99
        }
      }
    end

    it 'updates item successfully' do
      patch "/api/v1/items/#{item.id}", params: update_item_params

      expect(response).to have_http_status(:success)
    end

    it 'can update item with correct attributes' do
      patch "/api/v1/items/#{item.id}", params: update_item_params

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data][:attributes][:name]).to eq(update_item_params[:item][:name])
      expect(item[:data][:attributes][:description]).to eq(update_item_params[:item][:description])
      expect(item[:data][:attributes][:unit_price]).to eq(update_item_params[:item][:unit_price])
    end

    it 'can update with partial data' do
      patch "/api/v1/items/#{item.id}", params: update_partial_item_params

      expect(response).to have_http_status(:success)
    end

    it 'has sad path for item not updated' do
      patch "/api/v1/items/#{item.id}", params: update_wrong_item_params

      expect(response).to have_http_status(:not_found)
    end

    it 'has sad path if no merchant id is present' do
      patch "/api/v1/items/#{item.id}", params: update_no_merchant_id

      expect(response).to have_http_status(:not_found)
    end

    it 'has sad path if no item is present' do
      patch "/api/v1/items/9000", params: update_no_merchant_id

      expect(response).to have_http_status(:not_found)
    end
  end
end