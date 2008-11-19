require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/products with products" do
  before(:each) do
    @order_paid = mock_model( Order, :to_param => "1" )
    @order_paid.should_receive(:name).and_return("Name1")
    @order_paid.should_receive(:value).and_return(23.99)
    @order_paid.stub!(:status).and_return("PAID")
    @order_paid.should_receive(:updated_at).and_return(Time.now-2.hours)

    @order_paid2 = mock_model( Order, :to_param => "2" )
    @order_paid2.should_receive(:name).and_return("Name2")
    @order_paid2.should_receive(:value).and_return(35.00)
    @order_paid2.stub!(:status).and_return("PAID")
    @order_paid2.should_receive(:updated_at).and_return(Time.now-1.hours)
    
    @order_shipped = mock_model( Order, :to_param => "3" )
    @order_shipped.should_receive(:name).and_return("Name3")
    @order_shipped.should_receive(:value).and_return(25.65)
    @order_shipped.stub!(:status).and_return("SHIPPED")
    @order_shipped.should_receive(:updated_at).and_return(Time.now-3.hours)

    @order_shipped2 = mock_model( Order, :to_param => "4" )
    @order_shipped2.should_receive(:name).and_return("Name4")
    @order_shipped2.should_receive(:value).and_return(60.04)
    @order_shipped2.stub!(:status).and_return("SHIPPED")
    @order_shipped2.should_receive(:updated_at).and_return(Time.now-4.hours)

    @order_pending = mock_model( Order, :to_param => "5" )
    @order_pending.should_receive(:name).and_return("Name5")
    @order_pending.should_receive(:value).and_return(10.10)
    @order_pending.stub!(:status).and_return("PENDING")
    @order_pending.should_receive(:updated_at).and_return(Time.now-5.hours)

    @order_cancelled = mock_model( Order, :to_param => "6" )
    @order_cancelled.should_receive(:name).and_return("Name6")
    @order_cancelled.should_receive(:value).and_return(16.70)
    @order_cancelled.stub!(:status).and_return("CANCELLED")
    @order_cancelled.should_receive(:updated_at).and_return(Time.now-6.hours)

    assigns[:paid_orders] = [@order_paid, @order_paid2]
    assigns[:shipped_orders] = [@order_shipped, @order_shipped2]
    assigns[:pending_orders] = [@order_pending]
    assigns[:cancelled_orders] = [@order_cancelled]
    
    render 'admin/orders/index'
  end
  
  it "should show paid orders" do
    response.should have_tag("table tr+tr th.date", (Time.now-1.hours).strftime("%d %b, %y"))
    response.should have_tag("table th.date", (Time.now-2.hours).strftime("%d %b, %y"))
    response.should have_tag("table tr+tr td.text a[href=?]", admin_order_path(@order_paid2), /Name2/)
    response.should have_tag("table td.text a[href=?]", admin_order_path(@order_paid), /Name1/)
    response.should have_tag("table tr+tr td.num", "$35.00")
    response.should have_tag("table td.num", "$23.99")
  end

  it "should show shipped orders" do
    content_for(:sub).should have_tag("table th.date", (Time.now-3.hours).strftime("%d %b, %y"))
    content_for(:sub).should have_tag("table tr+tr th.date", (Time.now-4.hours).strftime("%d %b, %y"))
    content_for(:sub).should have_tag("table td.text a[href=?]", admin_order_path(@order_shipped), /Name3/)
    content_for(:sub).should have_tag("table tr+tr td.text a[href=?]", admin_order_path(@order_shipped2), /Name4/)
    content_for(:sub).should have_tag("table td.num", "$25.65")
    content_for(:sub).should have_tag("table tr+tr td.num", "$60.04")
  end

  it "should show unpaid (pending) orders" do
    response.should have_tag("table th.date", (Time.now-5.hours).strftime("%d %b, %y"))
    response.should have_tag("table td.text a[href=?]", admin_order_path(@order_pending), /Name5/)
    response.should have_tag("table td.num", "$10.10")
  end

  it "should show cancelled orders" do
    response.should have_tag("table th.date", (Time.now-6.hours).strftime("%d %b, %y"))
    response.should have_tag("table td.text a[href=?]", admin_order_path(@order_cancelled), /Name6/)
    response.should have_tag("table td.num", "$16.70")
  end
  
end