class ItemsSerializer 
  def self.format_items_index(items)
    { 
      data: items.map do |item|
      { id: item.id.to_s,
        type: item.class.name.downcase,
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
          }
        }
      end
    }
  end

  def self.format_item_show(item)
    {
      data: {
        id: item.id.to_s,
        type: item.class.name.downcase,
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
        }
      }
    }
  end
end