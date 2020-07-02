# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :tenant_switcher

  private

  def tenant_switcher
    tenant = request.headers['COMPANY']

    if tenant.present? && Company.pluck(:subdomain).include?(tenant)
      Apartment::Tenant.switch!(tenant)
    else
      render json: 'Not results found', status: 404
    end
  end
end
