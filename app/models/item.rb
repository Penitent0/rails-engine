class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.find_all_items(search_params)
    where("name ILIKE :search", search: "%#{search_params}%")
  end

  def self.find_all_by_price_min_max(min, max)
    where("unit_price >= :min_price AND unit_price <= :max_price", min_price: min, max_price: max)
  end

  def self.find_all_by_price_min(min)
    where("unit_price >= :min_price", min_price: min)
  end

  def self.find_all_by_price_max(max)
    where("unit_price <= :max_price", max_price: max)
  end
end
