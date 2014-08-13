class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :code
      t.integer :client_list_id

      t.timestamps
    end
  end
end
