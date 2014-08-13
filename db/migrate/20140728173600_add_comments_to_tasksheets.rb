class AddCommentsToTasksheets < ActiveRecord::Migration
  def change
    add_column :tasksheets, :comments, :string
  end
end
