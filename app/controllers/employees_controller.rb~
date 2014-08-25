class EmployeesController < ApplicationController
 before_filter :authorize
 require 'open-uri'
  def index
  #debugger
   @employees = Employee.all
   
  render action: 'index', :handlers => [:haml]
  end
  

  def new
    @employee = Employee.new
    @employee.build_user
    render action: 'new', :handlers => [:haml]
    
  end
  
  def show
  #debugger
    @employee = Employee.find(params[:id])
    respond_to do |format|
    format.html # show.html
   format.pdf { render :layout => false } 
   #debugger
    #render action: 'show', :handlers => [:haml]
  end
  end

  def create
    @employee = Employee.new(params[:employee])
    @user =  @employee.build_user(params[:employee][:user_attributes])
   
    if @employee.save
      @user.save
        redirect_to employees_path, notice: "Employee successfully created"
    else
      @employee.destroy        
      render action: "new",  :handlers => [:haml]
    end
  end
  
  def edit
    @employee = Employee.find(params[:id])
    @employee.user
    render action: 'edit', :handlers => [:haml]
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      redirect_to employees_path, notice: "Employee successfuly updated"
    else
      render action: "edit",  :handlers => [:haml]
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    debugger
    @employee.destroy
    redirect_to employees_path, notice: "Employee successfully deleted"
  end
  
  def send_mail
  #debugger
    @employee = Employee.find(params[:id])
     Notifier.welcome(@employee).deliver
     redirect_to employees_path, :notice=> 'Mail successfully delivered'
    #debugger
  end 
end
