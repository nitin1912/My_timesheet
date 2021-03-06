class TasksheetsController < ApplicationController
  before_filter :authenticate_user!
  #check_authorization
  load_and_authorize_resource :only => [:admin]
  
  def index
    @tasksheet = Tasksheet.new 
  end
  
  def new
    @tasksheet = Tasksheet.new  
  end
  
  def create
    flag_save = false
    flag_error =  false
    @task = []
    params[:array_of_row_key].split(",").each do |t|     
      @tasksheet = Tasksheet.new
      @tasksheet.flag = 0
      @tasksheet.employee_id = current_user.employee_id
      #debugger
      @tasksheet.client_list_id = params["client_list_id_#{t}"]
      @tasksheet.project_id = params["project_id_#{t}"]
      @tasksheet.activity_id = params["activity_id_#{t}"]
      @tasksheet.task = params["task_#{t}"]
      @tasksheet.date = params["date_#{t}"]
      @tasksheet.in_time = DateTime.strptime("#{params["in_time_#{t}"]["(1i)"]}-#{params["in_time_#{t}"]["(2i)"]}-#{params["in_time_#{t}"]["(3i)"]}T#{params["in_time_#{t}"]["(4i)"]}:#{params["in_time_#{t}"]["(5i)"]}", '%Y-%m-%dT%H:%M ')
      @tasksheet.out_time = DateTime.strptime("#{params["out_time_#{t}"]["(1i)"]}-#{params["out_time_#{t}"]["(2i)"]}-#{params["out_time_#{t}"]["(3i)"]}T#{params["out_time_#{t}"]["(4i)"]}:#{params["out_time_#{t}"]["(5i)"]}", '%Y-%m-%dT%H:%M ')
      @tasksheet.remarks = params["remarks_#{t}"]
      @task << @tasksheet
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
      redirect_to tasksheets_path, notice: "timesheet succesfully created"
    end     
  end

  def for_client_list  
    @index = params[:id].split('_').last
    @projects = Project.find_all_by_client_list_id(params["#{params["id"]}"])
    respond_to do |format| 
      format.js 
    end     
  end
  def report
 # debugger
    if params["client_list_id"].present? && params["project_id"].present? && params["activity_id"].present?
      if params["status"] == "new"
      #  debugger
        @flag = Tasksheet.where(:flag => '0')
        @user = @flag.where(:employee_id => current_user.employee_id)
        @client = @user.where(:client_list_id => params["client_list_id"])
        @project = @client.where(:project_id => params["project_id"])
        @activity = @project.where(:activity_id => params["activity_id"])
        @timesheet = @activity.where(:date => (params[:from].to_date)..(params[:to].to_date))
       
         # format.xlsx #{render xlsx: @timesheet}
         # debugger
        
      
      elsif params["status"] == "submitted"
        @flag = Tasksheet.where(:flag => '1')
        @user = @flag.where(:employee_id => current_user.employee_id)
        @client = @user.where(:client_list_id => params["client_list_id"])
        @project = @client.where(:project_id => params["project_id"])
        @activity = @project.where(:activity_id => params["activity_id"])
        @task = @activity.where(:date => (params[:from].to_date)..(params[:to].to_date))
      
      elsif params["status"] == "accepted"
        @flag = Tasksheet.where(:flag => '2')
        @user = @flag.where(:employee_id => current_user.employee_id)
        @client = @user.where(:client_list_id => params["client_list_id"])
        @project = @client.where(:project_id => params["project_id"])
        @activity = @project.where(:activity_id => params["activity_id"])
        @task = @activity.where(:date => (params[:from].to_date)..(params[:to].to_date))
      
      elsif params["status"] == "rejected"
        @flag = Tasksheet.where(:flag => '3')
        @user = @flag.where(:employee_id => current_user.employee_id)
        @client = @user.where(:client_list_id => params["client_list_id"])
        @project = @client.where(:project_id => params["project_id"])
        @activity = @project.where(:activity_id => params["activity_id"])
        @tasksheets = @activity.where(:date => (params[:from].to_date)..(params[:to].to_date))
      end
    end
  end
  
  def for_report
    @projects = Project.find_all_by_client_list_id(params["#{params["id"]}"])
    respond_to do |format| 
      format.js 
    end
  end
  
  def report_submit
  #debugger
  if params["pdf"]
      @timesheet = []
      params["hidden_value_array"].split().each do |t|
       @tasksheet = Tasksheet.new
        @tasksheet.client_list_id = params["client_list_id_#{t}"]
        @tasksheet.project_id = params["project_id_#{t}"]
        @tasksheet.activity_id = params["activity_id_#{t}"]
        @tasksheet.task = params["task_#{t}"]
        @tasksheet.date = params["date_#{t}"]
        @tasksheet.in_time = params["in_time_#{t}"]
        @tasksheet.out_time = params["out_time_#{t}"]
        @tasksheet.remarks = params["remarks_#{t}"]
        @timesheet << @tasksheet
      end
      render 'report_submit',  formats: :pdf
    end
    if params["download"]
      @timesheet = []
      params["hidden_value_array"].split().each do |t|
       @tasksheet = Tasksheet.new
        @tasksheet.client_list_id = params["client_list_id_#{t}"]
        @tasksheet.project_id = params["project_id_#{t}"]
        @tasksheet.activity_id = params["activity_id_#{t}"]
        @tasksheet.task = params["task_#{t}"]
        @tasksheet.date = params["date_#{t}"]
        @tasksheet.in_time = params["in_time_#{t}"]
        @tasksheet.out_time = params["out_time_#{t}"]
        @tasksheet.remarks = params["remarks_#{t}"]
        @timesheet << @tasksheet
      end
      render 'report_submit', :handlers => [:axlsx], formats: :xlsx
      

      #debugger
      
      
    end
      
    if params["submit"]
      @tasksheets = []
      @tasksheet_not_saved = []
      params["hidden_value_array"].split().each do |t|
        @tasksheet = Tasksheet.new
        @tasksheet.flag = 1
        @tasksheet.employee_id = current_user.employee_id
        @tasksheet.client_list_id = params["client_list_id_#{t}"]
        @tasksheet.project_id = params["project_id_#{t}"]
        @tasksheet.activity_id = params["activity_id_#{t}"]
        @tasksheet.task = params["task_#{t}"]
        @tasksheet.date = params["date_#{t}"]
        @tasksheet.in_time = params["in_time_#{t}"]
     # debugger
        @tasksheet.out_time = params["out_time_#{t}"]
        @tasksheet.remarks = params["remarks_#{t}"]
        if params["submit"].to_date == params["date_#{t}"].to_date
          @tasksheets << @tasksheet
        else
          @tasksheet_not_saved << @tasksheet
        end
      end
      @tasksheets.each do |t|
        t.save
       
      end
      @tasksheets.clear
      flash[:alert] = 'Report submitted to admin'
      render action: "report"
    end 
    if params["submit_all"]
      @tasksheets = []
      params["hidden_value_array"].split().each do |t|
        @tasksheet = Tasksheet.new
        @tasksheet.flag = 1
        @tasksheet.employee_id = current_user.employee_id
        @tasksheet.client_list_id = params["client_list_id_#{t}"]
        @tasksheet.project_id = params["project_id_#{t}"]
        @tasksheet.activity_id = params["activity_id_#{t}"]
        @tasksheet.task = params["task_#{t}"]
     # debugger 
        @tasksheet.date = params["date_#{t}"]
        @tasksheet.in_time = params["in_time_#{t}"]
     # debugger
        @tasksheet.out_time = params["out_time_#{t}"]
        @tasksheet.remarks = params["remarks_#{t}"]
        @tasksheets << @tasksheet
      end
      @tasksheets.each do |t|
        t.save
      end
      redirect_to report_path, notice: 'Report has been submitted to admin'
    end
  end 
  
  def admin_report_submit 
 #debugger
    if params["accept"]
     a = params["accept"].split.last
      @tasksheets = []
      @tasksheet_not_saved = []
      params["hidden_value_array"].split().each do |t|
        @tasksheet = Tasksheet.new
        @tasksheet.flag = 2
        @tasksheet.employee_id = params["employee_id_#{t}"]
        @tasksheet.client_list_id = params["client_list_id_#{t}"]
        @tasksheet.project_id = params["project_id_#{t}"]
        @tasksheet.activity_id = params["activity_id_#{t}"]
        @tasksheet.task = params["task_#{t}"]
     # debugger 
        @tasksheet.date = params["date_#{t}"]
        @tasksheet.in_time = params["in_time_#{t}"]
     # debugger
        @tasksheet.out_time = params["out_time_#{t}"]
        @tasksheet.remarks = params["remarks_#{t}"]
        if params["accept"].to_date == params["date_#{t}"].to_date
        #debugger
          @tasksheets << @tasksheet
        else 
          @tasksheet_not_saved << @tasksheet
        end
      end
      @tasksheets.each do |t|
      #debugger
        t.save
      end
      
      @tasksheets.clear
       flash[:alert] = "Report accepted for #{a}"
       render action: "admin"
    end  
    if params["accept_all"]
  
      @tasksheets = []
      params["hidden_value_array"].split().each do |t|
        @tasksheet = Tasksheet.new
        @tasksheet.flag = 2 
        @tasksheet.employee_id = params["employee_id_#{t}"]
        @tasksheet.client_list_id = params["client_list_id_#{t}"]
        @tasksheet.project_id = params["project_id_#{t}"]
        @tasksheet.activity_id = params["activity_id_#{t}"]
        @tasksheet.task = params["task_#{t}"]
     # debugger 
        @tasksheet.date = params["date_#{t}"]
        @tasksheet.in_time = params["in_time_#{t}"]
     # debugger
        @tasksheet.out_time = params["out_time_#{t}"]
        @tasksheet.remarks = params["remarks_#{t}"]
        @tasksheets << @tasksheet
      end
      @tasksheets.each do |t|
        t.save
      end
      redirect_to admin_path, notice: 'All report accepted'
    end  
    if params["reject_params"].present?
   #debugger
      @tasksheets = []
      @tasksheet_not_saved = []
      @timesheet = []
      a = params["reject_params"].split.last
      params["hidden_value_array"].split().each do |t|
        @tasksheet = Tasksheet.new
        @tasksheet.flag = 3
        @tasksheet.employee_id = params["employee_id_#{t}"]
        @tasksheet.client_list_id = params["client_list_id_#{t}"]
        @tasksheet.project_id = params["project_id_#{t}"]
        @tasksheet.activity_id = params["activity_id_#{t}"]
        @tasksheet.task = params["task_#{t}"]
      # debugger 
        @tasksheet.date = params["date_#{t}"]
        @tasksheet.in_time = params["in_time_#{t}"]
      # debugger
        @tasksheet.out_time = params["out_time_#{t}"]
        @tasksheet.remarks = params["remarks_#{t}"]
        @tasksheet.comments = params["comments_#{a}"]
        @timesheet << @tasksheet
        #debugger
        if params["reject_params"].to_date == params["date_#{t}"].to_date 
          @tasksheets << @tasksheet
        else
          @tasksheet_not_saved << @tasksheet
        end
      end
    # debugger
      
      if params["comments_#{a}"].present? 
        @tasksheets.each do |t|
          t.save
        end
        @tasksheets.clear
        @timesheet.clear
        flash[:alert] = " Report for #{a} rejected by admin"
        render action: "admin"
      else
        @tasksheets.clear
        @tasksheet_not_saved.clear
        flash[:alert]= "Please specify comments for #{a}"
        render action: "admin"
      end
    end  
    if params["reject_all_params"].present? 
    #debugger
      @tasksheets = []
      
      params["hidden_value_array"].split().each do |t|
        @tasksheet = Tasksheet.new
        @tasksheet.flag = 3
        @tasksheet.employee_id = params["employee_id_#{t}"]
        @tasksheet.client_list_id = params["client_list_id_#{t}"]
        @tasksheet.project_id = params["project_id_#{t}"]
        @tasksheet.activity_id = params["activity_id_#{t}"]
        @tasksheet.task = params["task_#{t}"]
        # debugger 
        @tasksheet.date = params["date_#{t}"]
        @tasksheet.in_time = params["in_time_#{t}"]
        # debugger
        @tasksheet.out_time = params["out_time_#{t}"]
        @tasksheet.remarks = params["remarks_#{t}"]
        @tasksheet.comments = params["comments"]
        @tasksheets << @tasksheet
        #@task << @tasksheet
       end
      if params["comments"].present? 
        @tasksheets.each do |t|
          t.save
        end
        redirect_to admin_path, notice: 'All report rejected by admin'
      else
      #debugger
       # @tasksheets.clear
        flash[:alert]= 'Please specify comments'
        render action: "admin" 
      end
    end  
  end
  
  def admin
  #debugger
    @tasksheets = []
    if params["employee_id"].present? && params["client_list_id"].blank? && params["project_id"].blank? && params["activity_id"].blank?
      @flag = Tasksheet.where(:flag => 1)
      @employee = @flag.where(:employee_id => params["employee_id"])
      @admin = @employee.where(:date => (params[:from].to_date)..(params[:to].to_date))
     #debugger
      @admin.each do |t|
        @tasksheets << t
      end
    end
    if params["employee_id"].present? && params["client_list_id"].present? && params["project_id"].blank? && params["activity_id"].blank?
      @flag = Tasksheet.where(:flag => 1)
      @employee = @flag.where(:employee_id => params["employee_id"])
      @client = @employee.where(:client_list_id => params["client_list_id"])
      @admin = @client.where(:date => (params[:from].to_date)..(params[:to].to_date))
      @admin.each do |t|
        @tasksheets << t
      end
    end
    if params["employee_id"].present? && params["project_id"].present? && params["client_list_id"].blank? && params["activity_id"].blank?
      @flag = Tasksheet.where(:flag => 1)
      @employee = @flag.where(:employee_id => params["employee_id"])
      @project = @employee.where(:project_id => params["project_id"])
      @admin = @project.where(:date => (params[:from].to_date)..(params[:to].to_date))
      @admin.each do |t|
        @tasksheets << t
      end
    end
    if params["employee_id"].present? && params["project_id"].blank? && params["client_list_id"].blank? && params["activity_id"].present?
      @flag = Tasksheet.where(:flag => 1)
      @employee = @flag.where(:employee_id => params["employee_id"])
      @activity = @employee.where(:activity_id => params["activity_id"])
      @admin = @activity.where(:date => (params[:from].to_date)..(params[:to].to_date))
      @admin.each do |t|
        @tasksheets << t
      end
    end
    if params["employee_id"].present? && params["client_list_id"].present? && params["project_id"].present? && params["activity_id"].blank?
      @flag = Tasksheet.where(:flag => 1)
      @employee = @flag.where(:employee_id => params["employee_id"])
      @client = @employee.where(:client_list_id => params["client_list_id"])
      @project = @client.where(:project_id => params["project_id"])
      @admin = @project.where(:date => (params[:from].to_date)..(params[:to].to_date))
     #  debugger 
      @admin.each do |t|
        @tasksheets << t
      end
    end
    if  params["employee_id"].present? && params["client_list_id"].present? && params["project_id"].blank? && params["activity_id"].present?
       @flag = Tasksheet.where(:flag => 1)
       @employee = @flag.where(:employee_id => params["employee_id"])
        @client = @employee.where(:client_list_id => params["client_list_id"])
        @activity = @client.where(:activity_id => params["activity_id"])
        @admin = @activity.where(:date => (params[:from].to_date)..(params[:to].to_date))
        @admin.each do |t|
        @tasksheets << t
      end
    end
    if params["employee_id"].present? && params["client_list_id"].blank? && params["project_id"].present? && params["activity_id"].present?
       @flag = Tasksheet.where(:flag => 1)
       @employee = @flag.where(:employee_id => params["employee_id"])
       @project = @employee.where(:project_id => params["project_id"])
       @activity = @project.where(:activity_id => params["activity_id"])
       @admin = @activity.where(:date => (params[:from].to_date)..(params[:to].to_date))
       @admin.each do |t|
         @tasksheets << t
       end
    end
     #if  params["employee_id"].present? && params["client_list_id"].blank? && params["project_id"].present? && params["activity_id"].p?
      #@flag = Tasksheet.where(:flag => 1)
      #@client = @flag.where(:client_list_id => params["client_list_id"])
      #@project = @client.where(:project_id => params["project_id"])
      #@project.each do |t|
       # @tasksheets << t
      #end
      #end
    #if params["client_list_id"].present? && params["activity_id"].present?
      #@flag = Tasksheet.where(:flag => 1)
     # @client = @flag.where(:client_list_id => params["client_list_id"])
      #@activity = @client.where(:activity_id => params["activity_id"])
      #@activity.each do |t|
       # @tasksheets << t
      #end
      #end
    #if params["project_id"].present? &&  params["activity_id"].present?
     # @flag = Tasksheet.where(:flag => 1)
      #@project = @flag.where(:project_id => params["project_id"])
       #@activity = @project.where(:activity_id => params["activity_id"])
       #activity.each do |t|
        #@tasksheets << t
      #end
      #end
    if params["employee_id"].present? && params["client_list_id"].present? && params["project"].present? && params["activity_id"].present?
      @flag = Tasksheet.where(:flag => 1 )
      @employee = @flag.where(:employee_id => current_user.employee_id)
     
      @client = @employee.where(:client_list_id => params["client_list_id"])
      @project = @client.where(:project_id => params["project_id"])
      @activity = @project.where(:activity_id => params["activity_id"])
      @tasksheet = @activity.where(:date => (params[:from].to_date)..(params[:to].to_date))
      @tasksheet.each do |t|
        @tasksheets << t
      end
    end
  end
  
 
end
