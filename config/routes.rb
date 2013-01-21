InDepth::Application.routes.draw do
	
	# post 'assignments/create_or_update'
	# get 'assignments/get_one/:assgt_id', controller: :assignments, action: :get_one, as: :get_one_assignment

  mount Ckeditor::Engine => '/ckeditor'

  authenticated :user do
    root to: "departments#home"
  end
	root to: "departments#home"
	
	##
	## Resources
	##
	resources :teachers, only: [:show]
  
  # resources :teachers, only: [:show] do
  #     resources :courses, only: [] do
  #       resources :assignments, only: [:new, :edit, :update, :show], shallow: true
  #     end
  #   end      
   
   
	resources :courses, only: [:show] do
    member do
      get :home
      get :edit_doc
    end
  end
	resources :teachers, only: [:show]
  
 	# Unrestful routes

	# Temporary routes to deal with old links
	match 'files/*path', via: :get, controller: :files, action: :pass_on
	match 'teachers/*path', via: :get, controller: :files, action: :pass_on

	get 'xyzzy', controller: :bridge, action: :import
	
  get "home", controller: 'departments', action: 'home'
  get "about", controller: 'departments', action: 'about'

	get "courses/:id/academic_year/:year/:teacher_id/:block/assignments", to: 'courses#home_with_assignments', as: :home_with_assignments
  get "sections/:id/assignments_pane",  to: 'sections#assignments_pane', as: :assignments_pane

  
	# get 'menus/home', to: 'menus#home', as: :home_menu
	# get 'menus/courses', to: 'menus#courses', as: :courses_menu
	# get 'menus/faculty', to: 'menus#faculty', as: :faculty_menu
	# get 'menus/manage', to: 'menus#manage', as: :manage_menu
  
  # resources :assignments

	devise_for :users, controllers: {sessions: 'users/sessions'}
	
  get 'teachers/:teacher_id/courses/:course_id/assignments/new', as: :new_assignment
  resources :assignments, except: [:new]

  # put 'text_documents/:id(.:format)', as: :update_text_document, to: 'text_documents#update'
  
  # match 'departments/update_doc/:value/:id', as: :update_dept_doc, to: 'departments#update_doc'
  
  get 'departments/edit_doc/:doc_id', to: 'departments#edit_doc', as: :edit_dept_doc
  get 'courses/edit_doc/:doc_id', to: 'courses#edit_doc', as: :edit_course_doc

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
 
  resources :text_documents, only: [:edit, :update] do
    member do
      get :ping
      get :unlock
    end
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
