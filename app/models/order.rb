# frozen_string_literal: true

class Order < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :store

  def total
    products.map(&:price).sum
  end
end
