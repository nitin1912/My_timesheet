class Employee < ActiveRecord::Base
  #include UserValidation
  attr_accessible :first_name, :last_name, :employee_code, :user_attributes
  #validates :user_attributes, presence: true
  validates :first_name, :last_name, presence: true, uniqueness: true
  validates :employee_code, presence: true, uniqueness: true, numericality: true
  #validates :email, :username, presence: true
  has_one :user
  validates_associated :user
  has_many :tasksheets
  accepts_nested_attributes_for :user, allow_destroy: true
  #attr_accessible :username, :email
  validates_format_of :first_name, :with => /^[a-z|A-Z]/, message: 'is not a string'
  validates_format_of :last_name, :with => /^[a-z|A-Z]/, message: 'is not a string'
end
  
