class ProductsController < ApplicationController
  def add_to_cart
    id = params[:id].to_i
    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      product = Product.find(id)
      flash[:notice] = "#{product.Name} added to cart."
    end
    redirect_to product_path(id)
  end

  def remove_from_cart
    id = params[:id].to_i
    logger.debug(id)
    session[:shopping_cart].delete(id)
    product = Product.find(id)
    redirect_to product_path(id)

    flash[:notice] = "#{product.Name} removed from cart."
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
