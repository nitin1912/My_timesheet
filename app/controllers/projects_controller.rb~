class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize

  def index
    @projects = Project.all
    render action: 'index', :handlers => [:haml]
   end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to projects_path, notice: "Project successfully created"
    else 
      @project.destroy
      render action: "new", :handlers => [:haml]
    end
  end

  def new
    @project = Project.new(params[:id])
    render action: 'new', :handlers => [:haml]
  end
  
  def edit
    @project = Project.find(params[:id])
    render action: 'edit', :handlers => [:haml]
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to projects_path, notice: "Project Successfully updated"
    else
      render action: "edit", :handlers => [:haml] 
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
      redirect_to projects_path, notice: "Project successfully deleted"
  end

  
end
