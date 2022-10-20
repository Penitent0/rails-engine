class MerchantsSerializer 
  def self.format_merchants_index(merchants)
    {
    data: merchants.map do |merchant|
      {
      id: merchant.id.to_s,
      type: merchant.class.name.downcase,
        attributes: { 
          name: merchant.name
        }
      }
    end
    }
  end

  def self.format_merchant_show(merchant)
    { data: {
      id: merchant.id.to_s,
      type: merchant.class.name.downcase,
      attributes: {
        name: merchant.name
        }
      }
    }
  end 
end