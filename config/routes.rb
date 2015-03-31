Rails.application.routes.draw do
  
  get 'ngo_password_resets/new'

  get 'ngo_password_resets/edit'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'ngo_sessions/new'

  get 'logins/new'

  get 'sessions/new'

  root 'static_pages#home'
  
  get 'home'        => 'static_pages#home'       # root_path
  get 'about'       => 'static_pages#about'      # about_path
  get 'events'      => 'events#index'            # events_path
  get 'volunteers'  => 'volunteers#index'        # volunteers_path
  get 'ngos'        => 'ngos#index'              # ngos_path
  get 'signup'      => 'sign_ups#new'            # signup_path
  

  get 'login'       => 'logins#new'              # login_path

  get 'vlogin'       => 'sessions#new'           # vlogin_path
  post 'vlogin'      => 'sessions#create'        # vlogin_path
  delete 'vlogout'   => 'sessions#destroy'       # vlogout_path

  get 'nlogin'       => 'ngo_sessions#new'       # nlogin_path
  post 'nlogin'      => 'ngo_sessions#create'    # nlogin_path
  delete 'nlogout'   => 'ngo_sessions#destroy'   # nlogout_path

  
  resources :volunteers
  resources :ngos
  resources :events
  resources :tags
 
  resources :volunteers do
    member do
      get :events
    end
  end
  
  # account activation email link
  resources :account_activations, only: [:edit]
  resources :ngo_account_activations, only: [:edit]
  
  # forgotten passwords
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :ngo_password_resets, only: [:new, :create, :edit, :update]
            
  # sign up and drop out of an event
  resources :event_volunteers, only: [:create, :destroy, :update]
  
#   # added for fb authentication
#   FacebookAuthExample::Application.routes.draw do
  get 'ngo_password_resets/new'

  get 'ngo_password_resets/edit'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'ngo_sessions/new'

  get 'logins/new'

#     get 'auth/:provider/callback', to: 'sessions#create'
#     get 'auth/failure', to: redirect('/')
#     get 'signout', to: 'sessions#destroy', as: 'signout'

#     resources :sessions, only: [:create, :destroy]
#     # resource :home, only: [:show]

#     # root to: "home#show"
#   end

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
