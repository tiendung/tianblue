class Admin::CategoriesController < ApplicationController
  
  layout "admin"
  before_filter :admin_required
  
  def index
    @categories = Category.all
    @page_title = "Categories"
  end
  
  # def show
  #   unless @category = Category.find(params[:id])
  #     redirect_to admin_categories_path
  #   end
  # end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Category created"
      redirect_to admin_categories_path
    else
      flash[:error] = "Could not create category"
      render :action => "new"
    end
  end

  def edit
    if @category = Category.find_by_name(params[:id])
      @image = @category.image
      @page_title = "Edit " + @category.name
    else
      redirect_to admin_categories_path
    end
  end

  def update
    if @category = Category.find_by_name(params[:id])
      if @category.update_attributes(params[:category])
        flash[:notice] = "Category updated"
        redirect_to admin_categories_path
      else
        flash[:error] = "Could not update category"
        render :action => "edit"
      end
    else
      redirect_to admin_categories_path 
    end
  end

  
end
