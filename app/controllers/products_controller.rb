class ProductsController < ApplicationController
  def index
    # @products = Product.where(is_available: true).where("price >= 50")
    @products = Product.good_product
  end
end
