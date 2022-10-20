require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) } 
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it 'has find one merchant class method' do
      merchant_1 = create(:merchant, name: "Randy")
      merchant_2 = create(:merchant, name: "Brandy")
      merchant_3 = create(:merchant, name: "Steven")
      merchant_4 = create(:merchant, name: "Alex")
      merchant_5 = create(:merchant, name: "Alexander")
      
      expect(Merchant.find_one_merchant("and")).to eq(merchant_5)
      expect(Merchant.find_one_merchant("ran")).to eq(merchant_2)
    end
  end
end
