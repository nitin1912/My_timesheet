class AddRootUser < ActiveRecord::Migration
  def self.up
    user = User.create!( :username => 'admin', :email => 'goldychauhan1912@gmail.com', :login => 'root', :password => 'ngobaraut' )
  end

  def self.down
    user = User.find_by_login( 'root' )
    user.destroy
  end
end
