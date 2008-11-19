class Admin::OrdersController < ApplicationController
  
  layout "admin"
  before_filter :admin_required

  def index
    @pending_orders = Order.pending
    @paid_orders = Order.paid
    @shipped_orders = Order.shipped
    @cancelled_orders = Order.cancelled
    @page_title = "Orders"
  end

  def show
    @order = Order.find(params[:id])
    @items = @order.items
  end
  
  def update
    @order = Order.find(params[:id])
    @order.status = params[:order][:status]
    if @order.save
      flash[:notice] = "Order #{@order.id} set to #{params[:order][:status]}"
      redirect_to admin_orders_path
    else
      flash[:error] = "Could not update order status" 
      redirect_to admin_order_path(@order)
    end
  end
  
  def destroy
    if @order = Order.find(params[:id])
      if @order.pending?
        if @order.destroy
          flash[:notice] = "Order Deleted"
          redirect_to admin_orders_path
        else
          flash[:error] = "Could not delete order"
          redirect_to admin_order_path(@order)
        end
      else
        flash[:notice] = "Order not PENDING, can not delete"
        redirect_to admin_order_path(@order)
      end
    else
      flash[:error] = "Order does not exist. Cannot delete"
      redirect_to admin_orders_path
    end
  end

end
