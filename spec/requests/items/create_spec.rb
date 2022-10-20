require 'rails_helper'

RSpec.describe "Api::V1::Items#Create", type: :request do
  describe 'POST /api/v1/items' do
    let(:merchant) { create(:merchant) }
    let(:item_params) do
      {
        merchant_id: merchant.id,
        item: {
        name: "Test Item",
        description: "The best test item testers can test",
        unit_price: 299.99,
        }
      }
    end

    let(:sad_path_wrong_items_params) do
      {
        merchant_id: merchant.id,
        item: {
        description: "The best test item testers can test",
        unit_price: 299.99,
        }
      }
    end
    let(:sad_path_no_merchant_id) do
      {
        item: {
        name: "Test Item",
        description: "The best test item testers can test",
        unit_price: 299.99,
        }
      }
    end 

    it 'it creates new item' do
      expect { post "/api/v1/items", params: item_params }.to change(Item, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates item with correct attributes' do
      post "/api/v1/items", params: item_params
      expect(Item.last).to have_attributes item_params[:item]
    end

    it 'has sad path if item is not created' do
      post "/api/v1/items", params: sad_path_wrong_items_params

      expect(response).to have_http_status(:not_found)
    end

    it 'has sad path if no merchant is given' do
      post "/api/v1/items", params: sad_path_no_merchant_id

      expect(response).to have_http_status(:not_found)
    end
  end
end