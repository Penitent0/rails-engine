class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.find_all_items(search_params)
    where("name ILIKE :search", search: "%#{search_params}%")
    # .order(name: :asc)
  end
end
