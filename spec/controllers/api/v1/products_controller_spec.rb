require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let(:products) { create_list(:product, 10) }
  let(:stores) { create_list(:store, 5) }
  let(:product_id) { products.first.id }


  describe "GET /api/v1/products" do
    before { get :index }

    it "return status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "return products list" do
      expect(json.size).to eq(10)
    end

  end

  describe "POST /api/v1/products" do
    let(:name) { Faker::Food.dish }
    let(:sku) { Faker::Code.imei }
    let(:type) { 'Pizza' }
    let(:price) {  Faker::Commerce.price.to_i }
    let(:valid_attributes) { { name: name, sku: sku, type: type, price: price } }

    context "when the request is valid" do
      before { post :create, params: valid_attributes }

      it "create a product" do
        expect(json['name']).to eq(name)
        expect(json['sku']).to eq(sku)
        expect(json['price']).to eq(price)
      end

      it "return status code 201" do
        expect(response).to have_http_status(:created)
      end
    end

    context "when the request is not valid" do
      before { post :create, params: { name: nil, sku: nil, type: nil, price: nil } }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "return a failure message" do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe "GET /api/v1/product/:id" do
    before { get :show, params: {id: product_id} }

    context "when the record exist" do
      it "return the product" do
        expect(json).not_to be_empty
      end

      it "return status code 200" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the record does not exist" do
      let(:product_id) { 999_999 }

      it "return a not found message" do
        expect(response.body).to match(/Couldn't find Product/)
      end

      it "return the status code 404" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT /api/v1/product/:id" do
    let(:name) { Faker::Food.dish }
    let(:valid_attributes) { { id: product_id, name: name } }
    before { put :update, params: valid_attributes }

    context "when the record exist" do
      it "update the record" do
        expect(response.body).to be_empty
      end

      it "return status code 204" do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe "DELETE /product/:id" do
    before { delete :destroy, params: {id: product_id} }

    it "return code 204" do
      expect(response).to have_http_status(:no_content)
    end
  end
end
