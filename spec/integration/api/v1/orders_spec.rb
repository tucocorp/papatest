# spec/integration/orders_spec.rb
require 'swagger_helper'

describe 'Orders API', type: :request, swagger_doc: 'api/v1/swagger_doc.json' do

  path '/api/v1/orders' do
    get 'Retrieves all orders.' do
      tags 'Orders'
      produces 'application/json'

      response '200', 'orders found' do
        before { create_list(:order, 2) }
        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/orders/{id}' do
    get 'Retrieves a order.' do
      tags 'Orders'
      description 'Retrieving a specific order by id'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Product found' do
        let(:order) { create(:order) }
        let(:id) { order.id }

        include_context 'with integration test'
      end

      response '404', 'Product not found' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/orders' do
    post 'Create a order.' do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          products_ids: { type: :string },
          store_id: { type: :string }
        },
        required: ['name', 'sku', 'type', 'price']
      }

      response '201', 'Product created' do
        let(:order) { create(:order) }

        include_context 'with integration test'
      end

      response '422', 'Product creation failed for parameter missing' do
        let(:order) { { name: 'foo' } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/orders/{id}' do
    delete 'Delete a order.' do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response '204', 'Destroy the order' do
        let(:id) { create(:order).id }

        run_test!
      end
    end
  end

end
