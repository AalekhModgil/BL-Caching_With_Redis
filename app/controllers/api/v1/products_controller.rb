class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def addProduct
    result= ProductService.create_product(product_params)

    if result[:success]
      # Rails.cache.delete("top_selling_products")
      REDIS.del("top_selling_products")
      render json:  result[:body], status: :created
    else
      render json: { errors: result[:error] }, status: :unprocessable_entity
    end
  end

  def top_selling_products
    #  products = Rails.cache.read("top_selling_products")
    products = REDIS.get("top_selling_products")

    if products.nil?
      products = ProductService.top_selling_products
      REDIS.setex("top_selling_products", 10.minutes.to_i, products.to_json)
    else
      products = JSON.parse(products)
    end
     #  Rails.cache.write("top_selling_products", products, expires_in: 10.minutes)
     render json: products, status: :ok
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
