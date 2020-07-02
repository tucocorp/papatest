# frozen_string_literal: true

# == Class for Company
class Company < ApplicationRecord
  # Callbacks
  after_create :create_tenant

  # Validations
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
