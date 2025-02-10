class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def addProduct
    result= ProductService.create_product(product_params)

    if result[:success]
      render json:  result[:body], status: :created
    else
      render json: { errors: result[:error] }, status: :unprocessable_entity
    end
  end

  # def top_selling_products

  # end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
