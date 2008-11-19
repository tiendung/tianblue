class Admin::CategoryImagesController < ApplicationController

  layout "admin"
  before_filter :get_category
  before_filter :admin_required

  def new
    @image = CategoryImage.new
    @page_title = "New Image for #{@category.name}"
  end

  def create
    if @category.create_image(params[:image])
      flash[:notice] = 'Image created successfully'
      redirect_to edit_admin_category_path(@category)     
    else
      flash[:error] = 'Could not create image'
      redirect_to new_admin_category_image_path(@category)     
    end
  end

  def destroy
    @image = @category.image
    if @image.destroy
      flash[:notice] = "Image Deleted"
    else
      flash[:error] = "Could not delete image"
    end
    redirect_to edit_admin_category_path(@category)
  end

  private
  
  def get_category
    @category = Category.find_by_name(params[:category_id])
  end

end
