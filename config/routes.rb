Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'

 	root to: "departments#home"

  get 'sections/:id/assignments_pane', to: 'sections#assignments_pane', as: :assignments_pane

  get 'courses/:course_id/teachers/:teacher_id/assignments/new', to: 'assignments#new', as: :new_assignment
  resources :assignments, only: [:create, :edit, :update, :destroy]
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

  get 'courses/:course_id/edit_course_doc/:id', to: 'course_documents#edit', as: :edit_course_doc
  put 'courses/:course_id/update_course_doc/:id', to: 'course_documents#update', as: :update_course_doc

  get 'courses/:id/home', to: 'courses#home', as: :course_home
  get 'courses/:id/home/:section_id', to: 'courses#home', as: :course_home_with_assts

  resources :section_assignments, only: [:index, :update]
  get 'section_assignments/retrieve', to: 'section_assignments#retrieve'

	# Temporary routes to deal with old links
	match 'files/*path', via: :get, controller: :files, action: :pass_on
	match 'teachers/*path', via: :get, controller: :files, action: :pass_on
  # unless Rails.application.config.consider_all_requests_local
  #   match '*not_found', to: 'errors#error_404'
  # end

  resources :sections, only: [:new, :create, :edit, :update, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
