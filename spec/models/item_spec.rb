require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoices).through(:invoice_items) } 
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'class methods' do
    it 'has find all items class method' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", description: "Newest Iphone!")
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", description: "Even newer Iphone!")
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", description: "Better than the iphone!")
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , description: "Powered by microwaves")

      expect(Item.find_all_items("phone")).to eq([item_1, item_2, item_4])
      expect(Item.find_all_items("new")).to eq([])
      expect(Item.find_all_items("iph")).to eq([item_1, item_2])
      expect(Item.find_all_items("droid")).to eq([item_4])
    end

    it 'has find all by price min max method' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", unit_price: 20.99)
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", unit_price: 9.99) 
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", unit_price: 200.15) 
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , unit_price: 75.50)

      expect(Item.find_all_by_price_min_max(10, 100)).to eq([item_1, item_4])
      expect(Item.find_all_by_price_min_max(9, 20)).to eq([item_2])
      expect(Item.find_all_by_price_min_max(100, 300)).to eq([item_3])
    end

    it 'has find all by price min method' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", unit_price: 20.99)
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", unit_price: 9.99) 
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", unit_price: 200.15) 
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , unit_price: 75.50)

      expect(Item.find_all_by_price_min(10)).to eq([item_1, item_3, item_4])
      expect(Item.find_all_by_price_min(70)).to eq([item_3, item_4])
      expect(Item.find_all_by_price_min(200)).to eq([item_3])
    end

    it 'has find all by price max method' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, name: "Iphone 14", unit_price: 20.99)
      item_2 = create(:item, merchant: merchant, name: "Iphone 22", unit_price: 9.99) 
      item_3 = create(:item, merchant: merchant, name: "Galaxy 2.5", unit_price: 200.15) 
      item_4 = create(:item, merchant: merchant, name: "Android Phone" , unit_price: 75.50)
      
      expect(Item.find_all_by_price_max(10)).to eq([item_2])
      expect(Item.find_all_by_price_max(21)).to eq([item_1, item_2])
      expect(Item.find_all_by_price_max(100)).to eq([item_1, item_2, item_4])
    end
  end
end
