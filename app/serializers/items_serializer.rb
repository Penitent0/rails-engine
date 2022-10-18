class ItemsSerializer 
  def self.format_items(items)
    items.map do |item|
      { id: item.id.to_s,
        type: item.class.name.downcase,
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
      }}
    end
  end
end