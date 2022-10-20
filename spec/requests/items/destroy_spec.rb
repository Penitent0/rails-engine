require 'rails_helper'

RSpec.describe "Api::V1::Items#Destroy", type: :request do
  describe 'DELETE api/v1/item/:id' do
    it 'can delete an item' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)

      expect { delete "/api/v1/items/#{item_1.id}" }.to change(Item, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it 'has sad path for item not found' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)

      delete "/api/v1/items/#{item_1.id}"

      expect(response).to have_http_status(:no_content)

      delete "/api/v1/items/#{item_1.id}"

      expect(response).to have_http_status(:not_found)
    end

    it 'can be deleted with associated invoice items' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      join_table = create(:invoice_item, item: item, invoice: invoice)

      expect { delete "/api/v1/items/#{item.id}" }.to change(InvoiceItem, :count).by(-1)
      
      expect(Item.count).to be(0)
    end
  end
end