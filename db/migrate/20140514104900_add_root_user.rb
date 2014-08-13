class AddRootUser < ActiveRecord::Migration
  def self.up
    user = User.create!( :username => 'admin', :email => 'admin@admin.com', :login => 'root', :password => '12345678' )
  end

  def self.down
    user = User.find_by_login( 'root' )
    user.destroy
  end
end
