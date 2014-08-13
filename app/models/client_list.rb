class ClientList < ActiveRecord::Base
  attr_accessible :name, :code
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true, numericality: true
  validates_length_of :name, maximum: 10
  validates_format_of :name, :with => /^[a-z|A-Z]/, message: 'is not a string'
  has_many :projects
  #client_list = ClientList.create(:address => '123 First St.')
  #company.errors.on(:name)      # => ["is too short (minimum is 5 characters)", "can't be blank"]
  #company.errors.on(:email)     # => "can't be blank"
  #company.errors.on(:address)   # => nil
  has_many :tasksheet
  def self.client_list
    @list = ClientList.all
    return @list
  end
end

