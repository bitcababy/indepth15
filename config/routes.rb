InDepth::Application.routes.draw do
	
  mount Ckeditor::Engine => '/ckeditor'

  authenticated :user do
    root to: "departments#home"
  end
	root to: "departments#home"
	
	##
	## Resources
	##
	# 
	resources :department, only: [] do
    member do
      get :home
      get :about
    end
    resources :courses, only: []
  end

  resources :courses, only: [] do
    member do
      get :home
    end
    resources :document, only: [:edit, :update]
    resources :sections, only: [] do
      member do
        get :assignments_pane
      end
      resources :assignments, only: []
    end
    resources :teachers, only: [] do
      authenticated :user do
        resources :assignments, only: [:new, :delete, :edit, :update, :create]
      end
    end
    resources :assignments, only: []
  end
  
  resources :sections, only: [] do
    get :assignments_pane, on: :member
  end
  
  resources :teachers, only: []
    
  authenticated :user do
    resources :assignments, only: [:new, :update, :edit, :create]
  end

	##
	## Other

	devise_for :users, controllers: {sessions: 'users/sessions'}
  
  get 'courses/:id/pane/:kind', to: 'courses#get_pane', as: :get_course_pane

  get 'departments/:id/pane/:pos', to: 'departments#get_pane', as: :get_dept_pane

  get "home", controller: 'departments', action: 'home'
  get "about", controller: 'departments', action: 'about'

	# Temporary routes to deal with old links
	match 'files/*path', via: :get, controller: :files, action: :pass_on
	match 'teachers/*path', via: :get, controller: :files, action: :pass_on
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
