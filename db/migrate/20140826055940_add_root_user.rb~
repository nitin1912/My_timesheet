class AddRootUser < ActiveRecord::Migration
  def self.up
    user = User.create!( :username => 'admin', :email => 'goldy.nitin@gmail.com', :login => 'root', :password => 'pass@123' )
    user.confirm!
  end

  def self.down
    user = User.find_by_login( 'root' )
    user.destroy
  end
end
