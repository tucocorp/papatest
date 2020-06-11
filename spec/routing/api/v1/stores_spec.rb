# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :routing do
  describe 'routing' do
    it 'route to #index' do
      expect(get: '/api/v1/stores').to route_to('api/v1/stores#index')
    end

    it 'route to #show' do
      expect(get: '/api/v1/stores/1').to route_to('api/v1/stores#show', id: '1')
    end

    it 'route to #create' do
      expect(post: '/api/v1/stores').to route_to('api/v1/stores#create')
    end

    it 'route to #update (PUT)' do
      expect(put: '/api/v1/stores/1').to route_to('api/v1/stores#update', id: '1')
    end

    it 'route to #update (PATCH)' do
      expect(patch: '/api/v1/stores/1').to route_to('api/v1/stores#update', id: '1')
    end

    it 'route to #destroy' do
      expect(delete: '/api/v1/stores/1').to route_to('api/v1/stores#destroy', id: '1')
    end
  end
end
