class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: { data: MerchantsSerializer.format_merchants(merchants) } 
  end

  def show
    begin
      merchant = Merchant.find(params[:id])
    rescue 
      return render json: { message: 'id not found' }, status: 404
    end 
    render json: MerchantSerializer.format_merchant(merchant)
  end
end
