class Project < ActiveRecord::Base
  attr_accessible :name, :code, :client_list_id 
  belongs_to :client_list
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true, numericality: true
  validates :client_list_id, presence: true
  validates_format_of :name, :with => /^[a-z|A-Z]/, message: 'is not a string'
  #def list
   # @client_lists = ClientList.all
  #end
  has_many :tasksheet
 

end
