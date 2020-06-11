include Response
class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /api/v1/orders
  def index
    @orders = Order.all
    json_response(@orders.map {|o| o.as_json(methods: [:total, :products]) })
  end

  # GET /api/v1/orders/1
  def show
    json_response(@order.as_json(methods: [:total, :products]))
  end

  # POST /api/v1/orders
  def create
    ActiveRecord::Base.transaction do
      begin
        @order = Order.create!(order_params)
        Api::V1::OrderMailer.create(@order).deliver_now
        json_response(@order.as_json(methods: [:total, :products]), :created)
      rescue => e
        json_response({error: e.message}, :unprocessable_entity)
        raise ActiveRecord::Rollback
      end
    end
  end

  # PATCH/PUT /api/v1/orders/1
  def update
    begin
      @order.update!(order_params)
      head :no_content
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  # DELETE /api/v1/orders/1
  def destroy
    begin
      @order.destroy!
      head :no_content
    rescue => e
      json_response({error: e.message}, :unprocessable_entity)
    end
  end

  private

  def set_order
    begin
      @order = Order.find(params[:id])
    rescue => e
      json_response({error: e.message}, :not_found)
    end
  end


  def order_params
    params.permit(:store_id, product_ids: [])
  end
end
