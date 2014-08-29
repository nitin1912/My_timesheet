class User < ActiveRecord::Base
  has_many :tasksheets
  # Include default devise modules. Others available are:
  
  #:lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :timeoutable, :confirmable,
         :recoverable, :rememberable, :trackable,:authentication_keys => [:login]
  # Setup accessible (or protected) attributes for your model
  attr_accessor :login  
  attr_accessible :login, :employee_id
  attr_accessible  :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  #validates_confirmation_of   :password, :on=>:create
  validates :username, presence: true
  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }
  validates_format_of :username, :with => /^[a-z|A-Z]/, message: 'is not a string'
  belongs_to :employee 
  #validates_presence_of :email, :on => :create
  #validates_presence_of :username, :on => :create
  #validate :validate_nested_attributes
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end
  def self.root_signed_in?
    current_user == 'admin'
  end

end
