class OrderService
  def self.create_order(params)
    order = Order.new(params)
    if order.save
      { success: true, body: order }
    else
      { success: false, error: order.errors }
    end
  end
end
