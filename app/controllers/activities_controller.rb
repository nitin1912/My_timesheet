class ActivitiesController < ApplicationController
   before_filter :authorize
    #load_and_authorize_resource
  #check_authorization
  before_filter :authenticate_user!
  def index
    @activities = Activity.all
    render action: 'index', :handlers => [:haml]
  end

  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      redirect_to activities_path
    else
      render action: 'new', :handlers => [:haml]
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
      redirect_to activities_path
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes(params[:activity])
      redirect_to activities_path
    else
      render action: 'edit', :handlers => [:haml]
    end
  end

  def edit
    @activity = Activity.find(params[:id])
     render action: 'edit', :handlers => [:haml]
  end

  def new
    @activity = Activity.new
    render action: 'new', :handlers => [:haml]
  end
end
