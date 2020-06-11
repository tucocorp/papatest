include Response

class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /api/v1/products
  def index
    @products = Product.all
    json_response(@products)
  end

  # GET /api/v1/products/1
  def show
    json_response(@product)
  end

  # POST /api/v1/products
  def create
    begin
      @product = Product.create!(product_params)
      json_response @product, :created
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /api/v1/products/1
  def update
    begin
      @product.update!(product_params)
      head :no_content
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  # DELETE /api/v1/products/1
  def destroy
    begin
      @product.destroy!
      head :no_content
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  def add_store
    begin
      @product.stores << Store.find(params[:store_id])
      head :no_content
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  def delete_store
    begin
      @product.stores.delete(Store.find(params[:store_id]))
      head :no_content
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  private

  def set_product
    begin
      @product = Product.find(params[:id])
    rescue => e
      json_response({ error: e.message }, :not_found)
    end
  end

  def product_params
    params.permit(:name, :sku, :type, :price)
  end

end
