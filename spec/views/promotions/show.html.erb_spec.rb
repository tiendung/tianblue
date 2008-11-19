require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/promotions/show.html.erb" do
  include PromotionsHelper
  
  before(:each) do
    assigns[:promotion] = @promotion = stub_model(Promotion,
      :promotion_code => "value for promotion_code",
      :promotion_name => "value for promotion_name",
      :discount_percentage => "1",
      :activate_now => false
    )
  end

  it "should render attributes in <p>" do
    render "/promotions/show.html.erb"
    response.should have_text(/value\ for\ promotion_code/)
    response.should have_text(/value\ for\ promotion_name/)
    response.should have_text(/1/)
    response.should have_text(/als/)
  end
end

