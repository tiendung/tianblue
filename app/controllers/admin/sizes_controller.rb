class Admin::SizesController < ApplicationController
  
  layout "admin"
  before_filter :admin_required
  
  def index
    @sizes = Size.all
    @page_title = "Sizes"
  end
  
  # def show
  #   unless @size = Size.find(params[:id])
  #     redirect_to admin_sizes_path
  #   end
  # end
  
  def new
    @size = Size.new
    @page_title = "New Size"
  end

  def create
    @size = Size.new(params[:size])
    if @size.save
      flash[:notice] = "Size created"
      redirect_to admin_sizes_path
    else
      flash[:error] = "Could not create size"
      render :action => "new"
    end
  end

  def edit
    if @size = Size.find_by_code(params[:id])
      @page_title = "Edit " + @size.name
    else
      redirect_to admin_sizes_path
    end
  end

  def update
    if @size = Size.find_by_code(params[:id])
      if @size.update_attributes(params[:size])
        flash[:notice] = "Size updated"
        redirect_to admin_sizes_path
      else
        flash[:error] = "Could not update size"
        render :action => "edit"
      end
    else
      redirect_to admin_sizes_path 
    end
  end

  def destroy
    if @size = Size.find_by_code(params[:id])
      if @size.destroy
        flash[:notice] = "Size destroyed"
      else
        flash[:error] = "Could not destroy #{@size.name}"
      end
    end
    redirect_to admin_sizes_path 
  end

  
end
