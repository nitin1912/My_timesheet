class SheetsController < ApplicationController
 before_filter :authenticate_user!
  def index
   @sheet = Sheet.new 
  end
  
  def new
   @sheet = Sheet.new
  end
  
  def create
    flag_save = false
    flag_error =  false
  #debugger
    @task = []
    params[:array_of_row_key].split(",").each do |t|     
      @sheet = Sheet.new
      @sheet.status = 'new'
      @sheet.employee_id = current_user.employee_id
      @sheet.client_list_id = params["client_list_id_#{t}"]
      @sheet.project_id = params["project_id_#{t}"]
      @sheet.activity_id = params["activity_id_#{t}"]
      @sheet.task = params["task_#{t}"]
      @sheet.date = params["date_#{t}"]
      @sheet.in_time = DateTime.strptime("#{params["in_time_#{t}"]["(1i)"]}-#{params["in_time_#{t}"]["(2i)"]}-#{params["in_time_#{t}"]["(3i)"]}T#{params["in_time_#{t}"]["(4i)"]}:#{params["in_time_#{t}"]["(5i)"]}", '%Y-%m-%dT%H:%M ')
      @sheet.out_time = DateTime.strptime("#{params["out_time_#{t}"]["(1i)"]}-#{params["out_time_#{t}"]["(2i)"]}-#{params["out_time_#{t}"]["(3i)"]}T#{params["out_time_#{t}"]["(4i)"]}:#{params["out_time_#{t}"]["(5i)"]}", '%Y-%m-%dT%H:%M ')
      @sheet.remarks = params["remarks_#{t}"]
      @task << @sheet
    end
    @out_time = []
    @in_time =[]
    @date = []
    flag = 0 
    @task.each do |t|
      if t.valid?  
        flag_save = true
        if flag == 1
          @date.each do |e|
            @in_time.each do |p|
              @out_time.each do |s|
                if t.date == e  && t.in_time == p && t.out_time == s
                  t.errors.add(:in_time, "Entry already taken")
                elsif t.date == e && t.in_time < p && t.in_time <= s && p < t.out_time 
                  t.errors.add(:in_time, "invalid time interval") 
                elsif  t.date ==e  && t.in_time >= p && t.in_time < s && t.out_time >= s
                  t.errors.add(:in_time, "In time sould be after out time")
                end 
              end
            end
          end
          @date.each do |e|
            @in_time.each do |p|
              @out_time.each do |s|
                if  t.date == e && t.in_time >= p && t.in_time < s && p < t.out_time  && t.out_time < s
                  t.errors.add(:in_time, "Entry is inside other entry")
                end
              end
            end
          end        
          if  t.errors.messages == {} && flag_error == false
            flag_save = true
          else 
            flag_save = false
            flag_error =  true
          end
        end
      else   
        flag_save = false
        flag_error =  true    
      end
      flag = 1
      @out_time << t.out_time
      @in_time <<  t.in_time 
      @date << t.date
    end
    
    if flag_error
      @out_time = []
      @in_time =[]
      @date = []
      @task.each do |t|
        @date.each do |e|
          @in_time.each do |p|
            @out_time.each do |s|
              if t.date == e  && t.in_time == p && t.out_time == s
                t.errors.add(:in_time, "Entry already taken")
              elsif t.date == e && t.in_time < p && t.in_time <= s && p < t.out_time 
                t.errors.add(:in_time, "invalid time interval") 
              elsif  t.date ==e  && t.in_time >= p && t.in_time < s && t.out_time >= s
                t.errors.add(:in_time, "In time sould be after out time")
              end 
            end
          end
        end
        @date.each do |e|
          @in_time.each do |p|
            @out_time.each do |s|
              if t.date == e && t.in_time >= p && t.in_time < s && p < t.out_time  && t.out_time < s
                t.errors.add(:in_time, "Entry is inside other entry")
              end
            end
            break
          end
        end
        @out_time << t.out_time
        @in_time <<  t.in_time 
        @date << t.date
      end
      render action: "new", :locals=> {:array_of_row_key=> params[:array_of_row_key]}
    end
    
    if flag_save
      @task.each do |s|
        s.save
      end
      redirect_to sheets_path, notice: "Timesheet succesfully created"
    end     
  end
  
   def for_client
    @index = params[:id].split('_').last
    @projects = Project.find_all_by_client_list_id(params["#{params["id"]}"])
    respond_to do |format| 
      format.js 
    end     
  end
end
