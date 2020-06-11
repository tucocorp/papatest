require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :controller do
  let!(:stores) { create_list(:store, 10) }
  let(:store_id) { stores.first.id }

  describe "GET /api/v1/stores" do
    before { get :index }

    it "return status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "return stores" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end

  describe "GET /api/v1/stores/:id" do
    before { get :show, params: {id: store_id} }

    context "when the record exist" do
      it "return the status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "return the store" do
        expect(json).not_to be_empty
      end
    end

    context "when the record does not exist" do
      let(:store_id) { 9999999 }

      it "return the status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "return a not found message" do
        expect(response.body).to match(/Couldn't find Store/)
      end
    end
  end

  describe "POST /api/v1/stores" do
    let(:name) { Faker::Lorem.word }
    let(:email) { Faker::Internet.email }
    let(:address) { Faker::Address.full_address }
    let(:phone) { Faker::PhoneNumber.phone_number }

    let(:valid_attributes) { { name: name, address: address, email: email, phone: phone } }

    context "when the request is valid" do
      before { post :create, params: valid_attributes }

      it "return status code 201" do
        expect(response).to have_http_status(:created)
      end

      it "create a store" do
        expect(json['name']).to eq(name)
        expect(json['email']).to eq(email)
        expect(json['address']).to eq(address)
        expect(json['phone']).to eq(phone)
      end
    end

    context "when the request is not valid" do
      before { post :create, params: { name: nil, email: nil, address: nil, phone: nil } }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "return a failure message" do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe "PUT /api/v1/store/:id" do
    let(:name) { Faker::Lorem.word }
    let(:valid_attributes) { { id: store_id, name: name } }
    before { put :update, params: valid_attributes }

    context "when the record exist" do
      it "return status code 204" do
        expect(response).to have_http_status(:no_content)
      end

      it "update the record" do
        expect(response.body).to be_empty
      end
    end
  end

  describe "DELETE /store/:id" do
    before { delete :destroy, params: {id: store_id} }

    it "return code 204" do
      expect(response).to have_http_status(:no_content)
    end
  end
end
