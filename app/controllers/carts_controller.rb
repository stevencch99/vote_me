class CartsController < ApplicationController
  # before_action :authenticate_user!

  def show
  end

  def add
    cart = Cart.from_hash(session[:cart9527])

    cart.add_item(params[:id])
    session[:cart9527] = cart.serialize

    redirect_to products_path, notice: "已加入至購物車"
  end
end