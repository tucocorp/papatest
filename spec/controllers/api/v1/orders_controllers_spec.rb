require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  let!(:orders) { create_list(:order, 10) }
  let(:order_id) { orders.first.id }
  let(:products) { create_list(:product, 5) }
  let(:updated_products) { create_list(:product, 5) }
  let(:store) { create(:store) }

  describe 'GET /api/v1/order' do
    before { get :index }

    it 'return orders list' do
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/order/:id' do
    before { get :show, params: { id: order_id } }

    context 'when the record exist' do
      it 'return the order' do
        expect(json).not_to be_empty
      end

      it 'return status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:order_id) { 999_999 }

      it 'return a not found message' do
        expect(response.body).to match(/Couldn't find Order with/)
      end

      it 'return the status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/order' do
    let(:valid_attributes) { { store_id: store.id, product_ids: products.map(&:id) } }

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }

      it 'create a new order' do
      	expect(json['products'].map { |p| p['id'] } ).to eq(products.map(&:id))
        expect(json['total']).to eq(products.map(&:price).sum)
        expect(json['store_id']).to eq(store.id)
      end

      it 'return status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post :create, params: { product_ids: nil, store_id: nil } }

      it 'return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return a failure message' do
        expect(response.body).to match(/Store must exist/)
      end
    end
  end

  describe 'PUT /api/v1/order/:id' do
    let(:valid_attributes) { { id: order_id, product_ids: updated_products.map(&:id), store_id: store.id } }
    before { put :update, params: valid_attributes }

    context 'when the record exist' do
      it 'update the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE /api/v1/order/:id' do
    before { delete :destroy, params: { id: order_id } }

    it 'return code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
