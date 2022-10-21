class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id].nil?
      items = Item.all
    else
      merchant = Merchant.find(params[:merchant_id])
      items = merchant.items
    end
    if items.empty?
      render json: { error: "No items found" },status: :not_found
    else
      render json: ItemsSerializer.format_items_index(items)
    end
  end

  def show
    begin
      item = Item.find(params[:id])
    rescue StandardError => e
      return render json: ErrorSerializer.errors(e),status: :not_found
    end
    render json: ItemsSerializer.format_item_show(item)
  end

  def create
    begin
      merchant = Merchant.find(params[:merchant_id])
      item = merchant.items.new(item_params)
    rescue StandardError => e
      return render json: ErrorSerializer.errors(e),status: :not_found
    end
    if item.save 
      render json: ItemsSerializer.format_item_show(item), status: :created
    else
      render json: { error: item.errors }, status: :not_found
    end
  end

  def update
    begin
      item = Item.find(params[:id])
    rescue StandardError => e
      return render json: ErrorSerializer.errors(e),status: :not_found
    end
    if item.update(item_params)
      render json: ItemsSerializer.format_item_show(item), status: :ok
    else
      render json: ErrorSerializer.update_fail(item.errors),status: :not_found
    end
  end

  def destroy
    begin
      item = Item.find(params[:id])
    rescue StandardError => e
      return render json: ErrorSerializer.errors(e),status: :not_found
    end
    item.destroy
  end

  def find_all
    if params[:name].nil? && (params[:min_price].nil? && params[:max_price].nil?)
      return render json: ErrorSerializer.bad_request, status: :bad_request
    end
    if params[:name] && (!params[:min_price].nil? || !params[:max_price].nil?)
      return render json: { error: "cannot search for name and price" }, status: :bad_request
    elsif params[:name] == ""
      return render json: ErrorSerializer.bad_request, status: :bad_request
    end
    if !params[:min_price].nil? && !params[:max_price].nil?
      if params[:min_price].to_i.positive? && params[:max_price].to_i.positive?
        items = Item.find_all_by_price_min_max(params[:min_price], params[:max_price])
      else
        return render json: { error: "price must be positive" }, status: :bad_request
      end
    elsif !params[:min_price].nil?
      if params[:min_price].to_i.positive? 
        items = Item.find_all_by_price_min(params[:min_price])
      else 
        return render json: { error: "price must be positive" }, status: :bad_request
      end
    elsif !params[:max_price].nil?
      if params[:max_price].to_i.positive?
        items = Item.find_all_by_price_max(params[:max_price])
      else
        return render json: { error: "price must be positive" }, status: :bad_request
      end
    elsif !params[:name].nil?
      items = Item.find_all_items(params[:name])
    end
    if items.empty?
      render json:ErrorSerializer.bad_request,status: :bad_request
    else
      render json: ItemsSerializer.format_items_index(items)
    end
  end

  private 
  def item_params 
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
