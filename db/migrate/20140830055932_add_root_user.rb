class AddRootUser < ActiveRecord::Migration
  def self.up
    user = User.new( :username => 'admin', :email => 'admin@admin.com', :login => 'root', :password => '12345678' )
    user.skip_confirmation!
    user.save
  end

  def self.down
    user = User.find_by_login( 'root' )
    user.destroy
  end
end
