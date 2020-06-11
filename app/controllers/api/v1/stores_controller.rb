include Response

class Api::V1::StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]

  # GET /api/v1/stores
  # GET /api/v1/stores.json
  def index
    @stores = Store.all
    json_response(@stores)
  end

  # GET /api/v1/stores/1
  # GET /api/v1/stores/1.json
  def show
    json_response(@store)
  end

  # POST /api/v1/stores
  # POST /api/v1/stores.json
  def create
    begin
      @store = Store.create!(store_params)
      json_response @store, :created
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /api/v1/stores/1
  # PATCH/PUT /api/v1/stores/1.json
  def update
    begin
      @store.update!(store_params)
      head :no_content
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  # DELETE /api/v1/stores/1
  # DELETE /api/v1/stores/1.json
  def destroy
    begin
      @store.destroy!
      head :no_content
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  private

    def set_store
      begin
        @store = Store.find(params[:id])
      rescue => e
        json_response({error: e.message}, :not_found)
      end
    end

    def store_params
      params.permit(:name, :email, :address, :phone)
    end
end
