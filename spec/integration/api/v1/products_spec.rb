# spec/integration/products_spec.rb
require 'swagger_helper'

describe 'Products API', type: :request, swagger_doc: 'api/v1/swagger_doc.json' do

  path '/api/v1/products' do
    get 'Retrieves all products.' do
      tags 'Products'
      produces 'application/json'

      response '200', 'products found' do
        before { create_list(:product, 2) }
        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/products/{id}' do
    get 'Retrieves a product.' do
      tags 'Products'
      description 'Retrieving a specific product by id'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Product found' do
        let(:product) { create(:product) }
        let(:id) { product.id }

        include_context 'with integration test'
      end

      response '404', 'Product not found' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/products' do
    post 'Create a product.' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          sku: { type: :string },
          type: { type: :string },
          price: { type: :string },
        },
        required: ['name', 'sku', 'type', 'price']
      }

      response '201', 'Product created' do
        let(:product) { create(:product) }

        include_context 'with integration test'
      end

      response '422', 'Product creation failed for parameter missing' do
        let(:product) { { name: 'foo' } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/products/{id}' do
    delete 'Delete a product.' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response '204', 'Destroy the product' do
        let(:id) { create(:product).id }

        run_test!
      end
    end
  end

end
