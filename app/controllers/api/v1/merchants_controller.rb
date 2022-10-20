class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    if merchants.empty?
      render json: { error: "No merchants found" }, status: :not_found 
    else
      render json: MerchantsSerializer.format_merchants_index(merchants) 
    end
  end

  def show
    begin
      if params[:item_id]
        merchant = Item.find(params[:item_id]).merchant
      else
        merchant = Merchant.find(params[:id])
      end
    rescue StandardError => e
      return render json: ErrorSerializer.errors(e),status: :not_found 
    end 
    render json: MerchantsSerializer.format_merchant_show(merchant)
  end

  def find
    begin
      merchants = Merchant.all
    rescue StandardError => e10
      return render json: ErrorSerializer.errors(e),status: :not_found
    end
    if merchants.find_one_merchant(params[:name]).nil? 
      render json: { data: {
        "#{params[:name]}": {
          error: "Not found"
          }
        }
      },status: :not_found
    elsif params[:name] == "" || params[:name].nil?
      render json: { data: [] },status: :bad_request
    else
      render json: MerchantsSerializer.format_merchant_show(merchants.find_one_merchant(params[:name]))
    end
  end
end
