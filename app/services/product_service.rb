class ProductService
  def self.create_product(params)
    product = Product.new(params)
    if product.save
      { success: true, body: product }
    else
      { success: false, error: product.errors }
    end
  end
end
