class CreateTasksheets < ActiveRecord::Migration
  def change
    create_table  :tasksheets do |t|
      t.integer   :client_list_id
      t.integer   :project_id
      t.integer   :activity_id
      t.string    :task
      t.datetime  :date      
      t.datetime  :in_time
      t.datetime  :out_time
      t.string    :remarks

      t.timestamps
    end
  end
end
