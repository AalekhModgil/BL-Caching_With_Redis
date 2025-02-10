class Api::V1::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def addOrder
    result = OrderService.create_order(order_params)

    if result[:success]
      # Rails.cache.delete("top_selling_products")
      REDIS.del("top_selling_products")
      render json:  result[:body], status: :created
    else
      render json: { errors: result[:error] }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :quantity)
  end
end
