class Activity < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, uniqueness: true
  validates_format_of :name, :with => /^[a-z|A-Z]/, message: 'is not a string'
  has_many :tasksheet
  
  def self.list
    @list = Activity.all
  end
end
