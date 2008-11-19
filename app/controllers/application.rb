# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c4667c5597ed5b1515f2020d26ddf3e4'
  
  def get_cart
    @cart = Cart.find_or_create_by_id(session[:cart]) if session[:cart]
    unless @cart
      @cart = Cart.create
      session[:cart] = @cart.id
    end
  end
  
  def admin_required
    (authorized? && current_user.admin?) || access_denied
  end
  
  def clear_promotion_signup
    session[:promotion_id] = nil
  end
  
  def bind_signup_to_promotion(code)
    promotion =  Promotion.find_by_promotion_code(code)

    session[:promotion_id] = promotion || promotion.id
  end
  
  def current_user_promotion
    current_user && current_user.get_promotion
  end
end
