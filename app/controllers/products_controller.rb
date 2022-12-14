class ProductsController < ApplicationController
  def add_to_cart
    id = params[:id].to_i
    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      product = Product.find(id)
      flash[:notice] = "#{product.name} added to cart."
    end
    redirect_to product_path(id)
  end

  def remove_from_cart
    id = params[:id].to_i
    logger.debug(id)
    session[:shopping_cart].delete(id)
    product = Product.find(id)
    redirect_to product_path(id)

    flash[:notice] = "#{product.name} removed from cart."
  end

  def index
    @products = Product.all.page(params[:page])
    @count = Product.all.count
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    category_id = params[:categories]
    @query = params[:keywords]


    @products = if category_id != "0"
                  Product.where("name LIKE ? AND category_id = ?", wildcard_search,
                                category_id).page(params[:page])
                else
                  Product.where("name LIKE ?", wildcard_search).page(params[:page])
                end
  end
end
