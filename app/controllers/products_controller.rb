class ProductsController < ApplicationController

  before_filter :get_cart

  def index
    @products = Product.all
    @page_title = "Products"
  end
  
  def show
    if @product = Product.find_by_sku(params[:id])
      @cart_item = CartItem.new(:quantity=>1)
      @stock_units = @product.stock_units
      @page_title = @product.name
      @page_class = @product.category.name
    else
      redirect_to products_path
    end
  end

  def category
    @products = Product.in_category(params[:id])
    if @products
      @category = Category.find_by_name(params[:id])
      @image = @category.image
      @page_title = @category.title
      @page_class = @category.name
      render :action => :index
    else
      redirect_to products_path
    end
  end
end
