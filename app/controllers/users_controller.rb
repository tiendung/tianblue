class UsersController < ApplicationController
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :clear_promotion_signup, :except => [:new, :create]
  before_filter :find_promotion, :only => [:new, :create]
  
  # observer :user_observer 
    
  # render new.rhtml
  def new
    @promotion = Promotion.find(session[:promotion_id]) if session[:promotion_id]
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.promotion_id = params[:promotion_id]
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
            redirect_back_or_default('/home')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/home')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/home')
    end
  end

  # action to perform when the users clicks forgot_password
  def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:user][:email])
      @user.forgot_password
      @user.save
      redirect_back_or_default('/home')
      flash[:notice] = "A password reset link has been sent to your email address: #{params[:user][:email]}"
    else
      flash[:alert] = "Could not find a user with that email address: #{params[:user][:email]}"
    end
  end
  # action to perform when the user resets the password
  def reset_password
    @user = User.find_by_password_reset_code(params[:code])
    @page_title = "Reset Your Password"
    return if @user unless params[:user]
    if ((params[:user][:password] && params[:user][:password_confirmation]))
      self.current_user = @user # for the next two lines to work
      current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.password = params[:user][:password]
      current_user.reset_password
      flash[:notice] = current_user.save ? "Password reset successfully" : "Unable to reset password"
      redirect_back_or_default('/home')
    else
      flash[:alert] = "Password mismatch"
    end
  end

  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
  
  def find_promotion
    @promotion = Promotion.find(session[:promotion_id]) if session[:promotion_id]
  end
end
