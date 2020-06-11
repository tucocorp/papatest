# frozen_string_literal: true
class Store < ApplicationRecord
  has_and_belongs_to_many :products

  validates :name, length: { maximum: 250 }, presence: true
  validates :address, length: { maximum: 1000 }, presence: true
  validates :email, length: { maximum: 250 }, presence: true
  validates :phone, length: { maximum: 250 }, presence: true
end
