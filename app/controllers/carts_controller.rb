class CartsController < ApplicationController

  def show
    @cart = Cart.find(session[:cart], :include => :items) if session[:cart]
    if @cart
      @cart_items = @cart.items
    else
      @cart = Cart.create
      session[:cart] = @cart.id
      @cart_items = nil
    end
  end
  
  def destroy
    @cart = Cart.find(session[:cart], :include => :items) if session[:cart]
    if @cart
      Cart.delete(@cart.id)
      session[:cart] = nil
    end
    redirect_to :back
  end

end
