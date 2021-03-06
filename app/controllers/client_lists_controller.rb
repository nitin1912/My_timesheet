class ClientListsController < ApplicationController
  before_filter :authenticate_user!
   #load_and_authorize_resource
#check_authorization
  before_filter :authorize
  def index
    #debugger
    @client_lists = ClientList.all
    render action: 'index', :handlers => [:haml]
  end
  
  def new
    @client_list = ClientList.new
    render action: 'new', :handlers => [:haml]
  end
  
  def edit
    @client_list = ClientList.find(params[:id])
    render action: 'edit', :handlers => [:haml]
  end
  
  def show
    @client_list = ClientList.find(params[:id])
    respond_to do |format|
    format.html # show.html.erb
    format.pdf { render :layout => false }  

    #render action: 'show', :handlers => [:haml]
  end
  end
  
  def create
    @client_list = ClientList.new(params[:client_list])
    if @client_list.save
      redirect_to client_list_path(@client_list), notice: "Client successfully added"
    else
      render action: "new", :handlers => [:haml]
    end
  end
  
  def destroy
    @client_list = ClientList.find(params[:id])
    @client_list.destroy
      redirect_to client_lists_path, notice: "Client successfully deleted"
  end
  
  def update
    @client_list = ClientList.find(params[:id])
    if @client_list.update_attributes(params[:client_list])
      redirect_to client_list_url, notice: "Client successfully updated"
    else
      render action: "edit", :handlers => [:haml]
    end
  end

    

   
end
