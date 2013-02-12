InDepth::Application.routes.draw do
	
  mount Ckeditor::Engine => '/ckeditor'

  authenticated :user do
    root to: "departments#home"
  end
	root to: "departments#home"
	
	##
	## Resources
	##
	resources :teachers, only: [:show]
    
  resources :section_assignments, only: [:edit, :update]
   
	resources :courses, only: [:show] do
    member do
      get :home
    end
  end
    
  get 'courses/:id/pane/:kind', to: 'courses#get_pane', as: :show_course_pane
  get 'departments/:id/pane/:pos', to: 'departments#get_pane', as: :get_dept_pane
  # get 'department/:id/pane/:which/edit', to: 'departments#edit_doc', as: :edit_department_doc
  
  
  resources :sections, only: [] do
    member do
      get :assignments_pane
    end
  end

 	# Unrestful routes

	# Temporary routes to deal with old links
	match 'files/*path', via: :get, controller: :files, action: :pass_on
	match 'teachers/*path', via: :get, controller: :files, action: :pass_on

	get 'xyzzy', controller: :bridge, action: :import
	
  get "home", controller: 'departments', action: 'home'
  get "about", controller: 'departments', action: 'about'

	get "courses/:id/year/:year/teacher/:teacher_id/block/:block", to: 'courses#home_with_assignments', as: :home_with_assignments
      
  get 'departments/:dept_id/documents/:id/edit', to: 'department_documents#edit', as: :edit_dept_doc
  put 'departments/:dept_id/documents/:id', to: 'department_documents#update', as: :update_dept_doc
  get 'courses/:course_id/documents/:id/edit', to: 'course_documents#edit', as: :edit_course_doc
  put 'courses/:course_id/documents/:id', to: 'course_documents#update', as: :update_course_doc
   
	devise_for :users, controllers: {sessions: 'users/sessions'}
	  
  get 'courses/:course_id/teachers/:teacher_id/assignments/new', to: 'assignments#new', as: :new_assignment
  resources :assignments, only: [:update, :edit, :create]

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
 
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
