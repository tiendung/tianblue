class Admin::ProductsController < ApplicationController

  layout "admin"
  before_filter :admin_required

  def index
    @products = Product.all
    @page_title = "Products"
  end

  def edit
    if @product = Product.find_by_sku(params[:id])
      @page_title = "Edit " + @product.name + " &#187; Products"
      @images = @product.images
      @stock_units = @product.stock_units
    else
      redirect_to admin_products_path
    end
  end
  
  def update
    @product = Product.find_by_sku(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = @product.name + " updated successfully"
      redirect_to admin_products_path
    else
      flash[:error] = @product.name + " could not be updated"
      redirect_to edit_admin_product_path(@product)
    end
  end
  
  def new
    @product = Product.new
    @page_title = "New Product"
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = @product.name + " created successfully"
      redirect_to admin_products_path
    else
      flash[:error] = "Could not create"
      redirect_to new_admin_product_path
    end
  end

end
