DailyReport::Application.routes.draw do

  resources :users do
    collection { post :search, to: 'users#index' }
  end
  resources :sessions
  resources :actives
  resources :reports
  resources :catalogs
  resources :groups
  resources :testmailers
  resources :namegroups
  resources :emails
  root to: 'static_pages#home'

  #users
 
  match '/update_avatar', to: 'users#update_avatar'
  match '/xls', to: 'users#index.xls'
  get 'get_name', to: 'reports#get_name'

  #active
  match '/show_info_user', to: 'actives#show_info_user'
  match '/active_user', to: 'actives#active_user'

  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  #report
  match '/user_report', to: 'reports#index'
  
  #groups
  match '/group_report', to: 'groups#group_report'
  match '/member_report', to: 'groups#member_report'
  
  #namegroup
  match '/setname', to: 'namegroups#setname'

  #groups
  match '/set_role', to: 'groups#set_role'
  match '/find_report_user', to: 'groups#find_report_user'
  match '/find_report_group', to: 'groups#find_report_group'
  match '/get_group_name', to: 'groups#get_group_name'
  
  #static_pages
  match '/faq_create_account', to: 'static_pages#faq_create_account'
  match '/faq_changepasswd', to: 'static_pages#faq_changepasswd'
  match '/faq_why_report', to: 'static_pages#faq_why_report'
  match '/faq_contact_manager', to: 'static_pages#faq_contact_manager'
  match '/faq_aboutsite', to: 'static_pages#faq_aboutsite'

  #emails
  match '/inbox', to: 'emails#inbox'
  match '/sent', to: 'emails#sent'
  match '/unread', to: 'emails#unread'

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
