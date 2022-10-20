class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id].nil?
      items = Item.all
    else
      merchant = Merchant.find(params[:merchant_id])
      items = merchant.items
    end
    if items.empty?
      render json: { error: "No items found"},status: :not_found
    else
      render json: ItemsSerializer.format_items_index(items)
    end
  end

  def show
    begin
      item = Item.find(params[:id])
    rescue StandardError => e
      return render json: { error: e.to_s }, status: :not_found
    end
    render json: ItemsSerializer.format_item_show(item)
  end

  def create
    begin
      merchant = Merchant.find(params[:merchant_id])
      item = merchant.items.new(item_params)
    rescue StandardError => e
      return render json: { error: e.to_s}, status: :not_found
    end
    if item.save 
      render json: ItemsSerializer.format_item_show(item), status: :created
    else
      render json: { error: item.errors }, status: :not_found
    end
  end

  def update 
    begin
      merchant = Merchant.find(params[:merchant_id])
      item = Item.find(params[:id])
    rescue StandardError => e
      return render json: { error: e.to_s}, status: :not_found
    end
    if item.update(item_params)
      render json: ItemsSerializer.format_item_show(item), status: :ok
    else 
      render json: { error: item.errors }, status: :not_found
    end
  end

  def destroy
    begin
      item = Item.find(params[:id])
    rescue StandardError => e
      return render json: { error: e.to_s}, status: :not_found
    end
    item.destroy
  end

  private 
  def item_params 
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
