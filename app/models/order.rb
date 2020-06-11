class Order < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :store

  def total
    return self.products.map(&:price).sum
  end
end
