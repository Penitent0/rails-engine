class MerchantSerializer 
  def self.format_merchant(merchant)
    { data: {
      id: merchant.id.to_s,
      type: merchant.class.name.downcase,
      attributes: {
        name: merchant.name
      }}}
  end 
end