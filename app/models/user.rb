require 'digest/sha1'

class User < ActiveRecord::Base
  belongs_to :validation
  has_and_belongs_to_many :teams
  has_many :collection_users
  has_many :collections, :through => :collection_users
  has_and_belongs_to_many :ontologies
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  validates_presence_of     :first_name
  validates_length_of       :first_name, :maximum => 30

  validates_presence_of     :last_name
  validates_length_of       :last_name,  :maximum => 30

  validates_presence_of     :login
  validates_length_of       :login,      :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,      :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,       :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,       :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,      :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,      :with => Authentication.email_regex, :message => Authentication.bad_email_message

  validates_presence_of     :validation_id

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :first_name, :last_name, :login, :email, :name, :password, :password_confirmation, :validation_id, :roles

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Start of code needed for the declarative_authorization plugin
  # 
  # Roles are stored in a serialized field of the User model.
  # For many applications a separate UserRole model might be a
  # better choice.
  serialize :roles, Array

  def role_symbols
     (roles || []).map {|r| r.to_sym}
  # roles.map do |role|
		# role.underscore.to_sym
	#end
  end
  
  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def <=>(other)
    self.name <=> other.name
  end
  
  protected
    
    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end
end