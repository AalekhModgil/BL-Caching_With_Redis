Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      post "products/add" , to: "products#addProduct" 

      post "orders/add" , to: "orders#addOrder"

      get "products/top_selling_products" , to: "products#top_selling_products"
      
    end
  end
end
