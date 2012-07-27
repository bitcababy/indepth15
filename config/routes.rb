DepthCharge::Application.routes.draw do

  get "home", controller: 'home', action: 'dept_info'
  get "about", controller: 'home', action: 'about'

	resources :teachers, :only => [:show]
	
	# get 'courses/:course_number/section
	
	for tab in %W(sections news policies resources information) do
		get "courses/:id/#{tab}_pane", to: "courses##{tab}_pane", as: "course_#{tab}_pane"
	end
	
	resources :courses do
		member do
			get 'home'
		end
	end
	
	# get 'teachers/:id, to: 'teachers#home', as: 'teacher_home_page'
	
	# namespace 'admin' do
	# 	resources 'courses' do
	# 		resources :sections, :only => [:new]
	# 	end
	# 	resources :sections, :only => [:create, :new, :edit, :update, :destroy,]
	# end
	
	root to: "home#dept_info"
	
  # devise_for :users
	devise_scope :user do
		match '/sign_in' => 'devise/sessions#new'
		get 'sign_out', to: 'devise/sessions#destroy'
	end

	
	match 'course/:course_number/block/:block/assignments' => 'assignments#page', :as => :assignments_page

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
