class MerchantsSerializer 
  def self.format_merchants(merchants)
    merchants.map do |merchant|
      { id: merchant.id.to_s,
        type: merchant.class.name.downcase,
        attributes: { 
          name: merchant.name
        }}
    end
  end
end