DepthCharge::Application.routes.draw do
	# authenticated :user do
	#  		root to: "home#dept_info"
	# end
	root to: "home#dept_info"
	
	resources :teachers, only: [:show]
	
	# get 'courses/:course_number/section
	
	for tab in %W(sections news policies resources information) do
		get "courses/:id/#{tab}_pane", to: "courses##{tab}_pane", as: "course_#{tab}_pane"
	end
	
	resources :courses, only: [:show] do
		get :show, controller: :courses, action: :show
	end
	
  namespace :teacher do 
		resources :sections
		resources :courses
	end

  namespace :admin do
		resources :assignments
		resources :sections
		resources :courses
		resources :users
	end

  devise_for :users, controllers: {sessions: :user_sessions}
		
	# Unrestful routes

  get "home", controller: 'home', action: 'dept_info'
  get "about", controller: 'home', action: 'about'

	get 'sections/:id/assignments', to: 'sections#assignments', as: :assignments_page
	
	get 'menus/home', to: 'menus#home', as: :home_menu
	get 'menus/courses', to: 'menus#courses', as: :courses_menu
	get 'menus/faculty', to: 'menus#faculty', as: :faculty_menu
	get 'menus/manage', to: 'menus#manage', as: :manage_menu
	
	
	# get 'files', to: 'file_manager#elfinder', as: :file_home

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
