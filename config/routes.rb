Timesheet::Application.routes.draw do
    #match 'tasksheets/for_clientlistid/' ,to: 'tasksheets#for_clientlistid', via: :get
  
   devise_scope :user do
     put "/confirm" => "confirmations#confirm"
     get '/login' => 'devise/sessions#new' , :as => 'login'
     post '/login' => 'devise/sessions#create', :as => 'login'
     get  "/forgot-password" => 'devise/passwords#new', :as => 'forgot_password'
     get '/confirmation-instruction' => 'confirmations#new', :as => 'confirmation_instruction'
   end
    devise_for :users, :controllers => { :confirmations => 'confirmations' }#, :skip => [:sessions ]
    resources :tasksheets    
    resources :sheets
    resources :employees
    #resources :users
    resources :home
    resources :activities
    resources :client_lists
    resources :projects 
  
    post "/report" => "tasksheets#report"
    post "/report_submit" => "tasksheets#report_submit"
    get "/for_client_list" => "tasksheets#for_client_list"
    get "/for_client" => "sheets#for_client"
    get "/report" => "tasksheets#report"
    get "/for_report" => "tasksheets#for_report"
    get "/admin" => "tasksheets#admin"
    post "/admin" => "tasksheets#admin"
    post "/admin_report_submit" => "tasksheets#admin_report_submit"
    post "/send_mail/:id" => "employees#send_mail", as: "send_mail"
    get "/create_mail/:id" => "employees#create_mail", as: "create_mail"
    post "/send_mail_all" => "employees#send_mail_all"
    get "/send_all" => "employees#send_all"
   # match '/projects/new', to: 'projects#new', via: :get
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
