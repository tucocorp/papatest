require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :routing do
  describe 'routing' do
    it '#index' do
      expect(get: '/api/v1/orders').to route_to('api/v1/orders#index')
    end

    it '#show' do
      expect(get: '/api/v1/orders/1').to route_to('api/v1/orders#show', id: '1')
    end

    it '#create' do
      expect(post: '/api/v1/orders').to route_to('api/v1/orders#create')
    end

    it '#update (PUT)' do
      expect(put: '/api/v1/orders/1').to route_to('api/v1/orders#update', id: '1')
    end

    it '#update (PATCH)' do
      expect(patch: '/api/v1/orders/1').to route_to('api/v1/orders#update', id: '1')
    end

    it '#destroy' do
      expect(delete: '/api/v1/orders/1').to route_to('api/v1/orders#destroy', id: '1')
    end
  end
end
