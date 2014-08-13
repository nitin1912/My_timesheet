class EmployeesController < ApplicationController
 before_filter :authorize
  def index
   @employees = Employee.all
   render action: 'index', :handlers => [:haml]
  end

  def new
    @employee = Employee.new
    @employee.build_user
    render action: 'new', :handlers => [:haml]
    
  end
  
  def show
    @employee = Employee.find(params[:id])
    render action: 'show', :handlers => [:haml]
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
    @employee.destroy
    redirect_to employees_path, notice: "Employee successfully deleted"
  end
end
