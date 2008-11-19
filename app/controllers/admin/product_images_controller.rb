class Admin::ProductImagesController < ApplicationController

  layout "admin"

  before_filter :get_product
  before_filter :admin_required

  def new
    @image = ProductImage.new
    @page_title = "New Image for #{@product.name}"
  end

  def create
    @image = ProductImage.new(params[:image])
    if @product.images << @image
      flash[:notice] = 'Image created successfully'
      redirect_to edit_admin_product_path(@product)     
    else
      flash[:error] = 'Could not create image'
      redirect_to new_admin_product_image_path(@product)     
    end
  end

  def destroy
    @image = ProductImage.find(params[:id])
    if @image.destroy
      flash[:notice] = "Image Deleted"
    else
      flash[:error] = "Could not delete image"
    end
    redirect_to edit_admin_product_path(@product)
  end

  private
  
  def get_product
    @product = Product.find_by_sku(params[:product_id])
  end
  
end
