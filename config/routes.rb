InDepth::Application.routes.draw do
	
  mount Ckeditor::Engine => '/ckeditor'

 	root to: "departments#home"
  
  get 'sections/:id/assignments_pane', to: 'sections#assignments_pane', as: :assignments_pane
  
  get 'courses/:course_id/teachers/:teacher_id/assignments/new', to: 'assignments#new', as: :new_assignment
  resources :assignments, only: [:create, :edit, :update, :delete]

	##
	## Other
	# 

	devise_for :users, controllers: {sessions: 'users/sessions'}
  
  get 'courses/:id/pane/:kind', to: 'courses#get_pane', as: :get_course_pane

  get 'departments/:id/pane/:pos', to: 'departments#get_pane', as: :get_dept_pane

  get "home", controller: 'departments', action: 'home'
  get "about", controller: 'departments', action: 'about'

  get 'departments/:dept_id/edit_dept_doc/:id', to: 'department_documents#edit', as: :edit_dept_doc
  put 'departments/:dept_id/update_dept_doc/:id', to: 'department_documents#update', as: :update_dept_doc
  
  get 'courses/:id/home', to: 'courses#home', as: :course_home
  get 'courses/:id/home/:section_id', to: 'courses#home', as: :course_home_with_assts
  
  resources :section_assignments, only: [:index, :update]

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
