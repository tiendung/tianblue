require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/promotions/index.html.erb" do
  include PromotionsHelper
  
  before(:each) do
    assigns[:promotions] = [
      stub_model(Promotion,
        :promotion_code => "value for promotion_code",
        :promotion_name => "value for promotion_name",
        :discount_percentage => "1",
        :activate_now => false
      ),
      stub_model(Promotion,
        :promotion_code => "value for promotion_code",
        :promotion_name => "value for promotion_name",
        :discount_percentage => "1",
        :activate_now => false
      )
    ]
  end

  it "should render list of promotions" do
    render "/promotions/index.html.erb"
    response.should have_tag("tr>td", "value for promotion_code", 2)
    response.should have_tag("tr>td", "value for promotion_name", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", false, 2)
  end
end

