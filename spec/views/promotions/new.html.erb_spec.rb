require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/promotions/new.html.erb" do
  include PromotionsHelper
  
  before(:each) do
    assigns[:promotion] = stub_model(Promotion,
      :new_record? => true,
      :promotion_code => "value for promotion_code",
      :promotion_name => "value for promotion_name",
      :discount_percentage => "1",
      :activate_now => false
    )
  end

  it "should render new form" do
    render "/promotions/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", promotions_path) do
      with_tag("input#promotion_promotion_code[name=?]", "promotion[promotion_code]")
      with_tag("input#promotion_promotion_name[name=?]", "promotion[promotion_name]")
      with_tag("input#promotion_discount_percentage[name=?]", "promotion[discount_percentage]")
      with_tag("input#promotion_activate_now[name=?]", "promotion[activate_now]")
    end
  end
end


