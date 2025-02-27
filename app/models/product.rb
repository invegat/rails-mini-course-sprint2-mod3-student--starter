class Product < ApplicationRecord
  has_many :order_product
  has_many :orders, through: :order_product
  validates :name, presence: true
  validates :cost_cents, numericality: { only_integer: true, greater_than: 0 }
  validates :inventory,  numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :in_stock, -> {  where("inventory > ?", 0)  }
  scope :out_of_stock, -> { where(inventory: 0) }  


  def available?
    inventory > 0
  end

  def reduce_inventory
    update(inventory: inventory - 1)
  end
end
