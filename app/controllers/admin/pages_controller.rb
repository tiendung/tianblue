class Admin::PagesController < ApplicationController

  layout "admin"
  before_filter :admin_required

  def index
    @pages = Page.all
    @page_title = "Pages"
  end

  def edit
    @page = Page.find_by_permalink(params[:id])
    if @page
      @page_title = "Edit " + @page.name + " &#187; Pages"
      @image = @page.image
    else
      redirect_to admin_pages_path
    end
  end
  
  def update
    if @page = Page.find_by_permalink(params[:id])
      if @page.update_attributes(params[:page])
        flash[:notice] = @page.name + " updated successfully"
        redirect_to admin_pages_path
      else
        flash[:error] = "Page could not be updated"
        render :action => :edit
      end
    else
      flash[:error] = "Page could not be found"
      redirect_to admin_pages_path
    end
  end
  
  def new
    @page = Page.new
    @page_title = "New Page"
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = @page.name + " created successfully"
      redirect_to admin_pages_path
    else
      flash[:error] = "Could not create page"
      render :action => :new
    end
  end

  def destroy
    if @page = Page.find_by_permalink(params[:id])
      if @page.destroy
        flash[:notice] = "Page destroyed"
        redirect_to admin_pages_path
      else
        flash[:error] = "Could not destroy page"
        redirect_to admin_pages_path
      end
    else
      flash[:error]= "Could not find page to destroy"
      redirect_to admin_pages_path
    end
  end


end
