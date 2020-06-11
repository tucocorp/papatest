# frozen_string_literal: true
class Store < ApplicationRecord
  validates :name, length: { maximum: 250 }, presence: true
  validates :address, length: { maximum: 1000 }, presence: true
  validates :email, length: { maximum: 250 }, presence: true
  validates :phone, length: { maximum: 250 }, presence: true
end
