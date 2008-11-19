class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://tianblue.com/activate/#{user.activation_code}"
  end
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://tianblue.com/"
  end
  
  def forgot_password(user)
    setup_email(user)
    @subject    += 'Forgotten Password'
    @body[:url]  = "http://tianblue.com/reset_password/#{user.password_reset_code}"
  end
  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset.'
    @body[:url]  = "http://tianblue.com/login"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = %w{"Tianblue" <noreply@tianblue.com>}
      @subject     = "[tianblue.com] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
