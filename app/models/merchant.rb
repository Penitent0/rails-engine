class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  
  validates_presence_of :name

  def self.find_one_merchant(search_params)
    where("name ILIKE :search", search: "%#{search_params}%")
    .order(name: :asc)
    .first
  end
end
