class Admin::StockUnitsController < ApplicationController
  layout "admin"

  before_filter :get_product
  before_filter :admin_required

  def edit
    @stock_unit = StockUnit.find(params[:id])
    if @stock_unit
      @page_title = "Edit " + @stock_unit.name + " &#187; StockUnits"
    else
      redirect_to edit_admin_product_path(@product)
    end
  end
  
  def update
    if @stock_unit = StockUnit.find(params[:id])
      if @stock_unit.update_attributes(params[:stock_unit])
        flash[:notice] = "StockUnit updated successfully"
        redirect_to edit_admin_product_path(@product)
      else
        flash[:error] = "StockUnit could not be updated"
        render :action => :edit
      end
    else
      flash[:error] = "StockUnit could not be found"
      redirect_to edit_admin_product_path(@product)
    end
  end
  
  def new
    @stock_unit = StockUnit.new
    @page_title = "New StockUnit"
  end
  
  def create
    @stock_unit = StockUnit.new(params[:stock_unit])
    @stock_unit.product = @product
    if @stock_unit.save
      flash[:notice] = "StockUnit created successfully"
      redirect_to edit_admin_product_path(@product)
    else
      flash[:error] = "Could not create StockUnit"
      render :action => :new
    end
  end

  def destroy
    if @stock_unit = StockUnit.find(params[:id])
      if @stock_unit.destroy
        flash[:notice] = "StockUnit destroyed"
        redirect_to edit_admin_product_path(@product)
      else
        flash[:error] = "Could not destroy StockUnit"
        redirect_to edit_admin_product_path(@product)
      end
    else
      flash[:error]= "Could not find StockUnit to destroy"
      redirect_to edit_admin_product_path(@product)
    end
  end

  private
  
  def get_product
    @product = Product.find_by_sku(params[:product_id])
  end
  
end
