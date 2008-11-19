require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/promotions/edit.html.erb" do
  include PromotionsHelper
  
  before(:each) do
    assigns[:promotion] = @promotion = stub_model(Promotion,
      :new_record? => false,
      :promotion_code => "value for promotion_code",
      :promotion_name => "value for promotion_name",
      :discount_percentage => "1",
      :activate_now => false
    )
  end

  it "should render edit form" do
    render "/promotions/edit.html.erb"
    
    response.should have_tag("form[action=#{promotion_path(@promotion)}][method=post]") do
      with_tag('input#promotion_promotion_code[name=?]', "promotion[promotion_code]")
      with_tag('input#promotion_promotion_name[name=?]', "promotion[promotion_name]")
      with_tag('input#promotion_discount_percentage[name=?]', "promotion[discount_percentage]")
      with_tag('input#promotion_activate_now[name=?]', "promotion[activate_now]")
    end
  end
end


