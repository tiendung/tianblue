class CartItemsController < ApplicationController

  before_filter :get_cart

  def create
    @stock_unit = StockUnit.find_by_sku(params[:cart_item][:sku])
    @cart.add_stock_unit(@stock_unit, params[:cart_item][:quantity] || 1)
    redirect_to :back
  end

end
