class AddRootUser < ActiveRecord::Migration
  def self.up
    user = User.create( :username => 'admin', :email => 'admin@admin.com', :login => 'root', :password => 'pass@123', :password_confirmation => 'pass@123' )
    user.confirm!
  end

  def self.down
    user = User.find_by_login( 'root' )
    user.destroy
  end
end
