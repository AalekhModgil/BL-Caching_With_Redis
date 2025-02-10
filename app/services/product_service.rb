class ProductService
  def self.create_product(params)
    product = Product.new(params)
    if product.save
      { success: true, body: product }
    else
      { success: false, error: product.errors }
    end
  end

  def self.top_selling_products
    Product.joins(:orders)
    .select("products.*,SUM(orders.quantity) as total_quantity")
    .group("products.id")
    .order("total_quantity desc").limit(10)
  end
end
