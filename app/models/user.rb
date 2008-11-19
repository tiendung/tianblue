require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::StatefulRoles
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login,    :case_sensitive => false
  validates_format_of       :login,    :with => RE_LOGIN_OK, :message => MSG_LOGIN_BAD

  validates_format_of       :name,     :with => RE_NAME_OK,  :message => MSG_NAME_BAD, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD

  has_many :orders
  belongs_to :promotion

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :receive_update, :promotion_id, :is_admin

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    u = find_in_state :first, :active, :conditions => {:login => login} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end
  def reset_password
    # First update the password_reset_code before setting the
    # reset_password flag to avoid duplicate mail notifications.
    self.attributes = {:password_reset_code => nil}
    @reset_password = nil
  end

  # Used in user_observer
  def recently_forgot_password?
    @forgotten_password
  end
  # Used in user_observer
  def recently_reset_password?
    @reset_password
  end
  # Used in user_observer
  def recently_activated?
    @activated
  end
  
  
  def admin?
    is_admin? ||
    login == "tphutton" ||
    email == "tphutton@tianblue.com"
  end
  
  
  def get_promotion
    p = Promotion.find_by_id(promotion_id)
    if not p.nil? and p.is_valid
      return p
    else
      return nil
    end
  end


  protected
  def make_password_reset_code
    self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end
  def make_activation_code
    self.deleted_at = nil
    self.activation_code = self.class.make_token
  end

end
# == Schema Info
# Schema version: 20080930130231
#
# Table name: users
#
#  id                        :integer(11)     not null, primary key
#  promotion_id              :integer(11)
#  activation_code           :string(40)
#  crypted_password          :string(40)
#  email                     :string(100)
#  is_admin                  :boolean(1)
#  login                     :string(40)
#  name                      :string(100)     default("")
#  password_reset_code       :string(40)
#  receive_update            :boolean(1)      default(TRUE)
#  remember_token            :string(40)
#  salt                      :string(40)
#  state                     :string(255)     default("passive")
#  activated_at              :datetime
#  created_at                :datetime
#  deleted_at                :datetime
#  remember_token_expires_at :datetime
#  updated_at                :datetime

