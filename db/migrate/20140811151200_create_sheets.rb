class CreateSheets < ActiveRecord::Migration
  def change
    create_table  :sheets do |t|
      t.integer   :client_list_id
      t.integer   :project_id
      t.integer   :activity_id
      t.string    :task
      t.datetime  :date      
      t.datetime  :in_time
      t.datetime  :out_time
      t.string    :remarks
      t.integer   :employee_id
      t.string    :status
      t.string    :comments
      
      t.timestamps
    end
  end
end
