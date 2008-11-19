class OrdersController < ApplicationController

  # before_filter :login_required, :except => [:payment_received, :new]
  before_filter :get_cart, :only => [:new, :create]
  protect_from_forgery :except => :payment_received
  
  def new
    unless @cart.empty?
      @items = @cart.items
      @page_title = "Checkout"
      @order = Order.new
      if logged_in?
        @order.name = current_user.name
        @order.email = current_user.email
      end
    else
      redirect_to cart_path
      flash[:error] = "Cart is empty!"
    end
  end

  def create
    unless @cart.empty?
      @order = Order.new_from_cart(@cart, params[:order], current_user_promotion )
      @order.user = current_user if logged_in?
      if @order.save
        @cart.destroy
        redirect_to order_path(@order)
      else
        flash[:error] = "Need to complete all fields"
        render :action => "new"
      end
    else
      flash[:error] = "Cannot checkout with an empty cart!"
      redirect_to cart_path
    end
  end
  
  def show
    @order = Order.find(params[:id])
    
    if @order && @order.user == current_user
      @items = @order.items
    else
      redirect_to orders_path
    end
  end
  
  def index
    @orders = current_user.orders
  end

  def payment_received
    @order = Order.find(params[:cartId])
    if params[:transStatus] == "Y"
      @order.status = "PAID"
      @order.transaction_reference = params[:transId]
      @order.save
      head 200
    else
      @order.status = "CANCELLED"
      redirect_to order_path(@order)
    end
  end
  
end
