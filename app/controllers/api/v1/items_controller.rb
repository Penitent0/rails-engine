class Api::V1::ItemsController < ApplicationController
  def index
    begin
      merchant = Merchant.find(params[:merchant_id])
      items = merchant.items
    rescue
      return render json: { message: items.errors }, status: 404
    end
    render json: { data: ItemsSerializer.format_items(items) }
  end
end
