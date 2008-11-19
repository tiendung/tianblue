class Admin::PageImagesController < ApplicationController

  layout "admin"
  before_filter :get_page
  before_filter :admin_required

  def new
    @image = PageImage.new
    @page_title = "New Image for #{@page.name}"
  end

  def create
    if @page.create_image(params[:image])
      flash[:notice] = 'Image created successfully'
      redirect_to edit_admin_page_path(@page)     
    else
      flash[:error] = 'Could not create image'
      redirect_to new_admin_page_image_path(@page)     
    end
  end

  def destroy
    @image = @page.image
    if @image.destroy
      flash[:notice] = "Image Deleted"
    else
      flash[:error] = "Could not delete image"
    end
    redirect_to edit_admin_page_path(@page)
  end

  private
  
  def get_page
    @page = Page.find_by_permalink(params[:page_id])
  end

end
