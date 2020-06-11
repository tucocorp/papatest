# spec/integration/stores_api_doc_spec.rb
require 'swagger_helper'

describe 'Stores API', type: :request, swagger_doc: 'api/v1/swagger_doc.json' do

  path '/api/v1/stores' do
    get 'Retrieves all stores.' do
      tags 'Stores'
      produces 'application/json'

      response '200', 'stores found' do
        before { create_list(:store, 2) }
        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/stores/{id}' do
    get 'Retrieves a store.' do
      tags 'Stores'
      description 'Retrieving a specific store by id'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Store found' do
        let(:store) { create(:store) }
        let(:id) { store.id }

        include_context 'with integration test'
      end

      response '404', 'Store not found' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/stores' do
    post 'Create a store.' do
      tags 'Stores'
      consumes 'application/json'
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          address: { type: :string },
          phone: { type: :string },
        },
        required: ['name', 'email', 'address', 'phone']
      }

      response '201', 'Store created' do
        let(:store) { create(:store) }

        include_context 'with integration test'
      end

      response '422', 'Store creation failed for parameter missing' do
        let(:store) { { name: 'foo' } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/stores/{id}' do
    delete 'Delete a store.' do
      tags 'Stores'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response '204', 'Destroy the store' do
        let(:id) { create(:store).id }

        run_test!
      end
    end
  end

end
