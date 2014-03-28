Doubtsync::Application.routes.draw do
  
  get "ambassador/proflist"
  post "ambassador/proflist" => 'ambassador#uploadFile'
  get "ambassador/resumeformat"
  get "colleges/new"
  post "colleges/new" => 'colleges#create'
  get "colleges/:id" => 'colleges#show'
  post "colleges/ambassadorregistration" => 'colleges#update'

  get "users/manage" => 'users#manage'
  post "users/manage" => 'users#save'
  get "users/:id" => 'users#index'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  get "main/index"
  get "main/feed"
  get 'main/user' => 'main#user'


  


  devise_for :users, path: "", path_names: { sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: '' }, :controllers => { :registrations => 'registers' }
  resources :posts
  # get 'register' => 'register#new', as: :register
  

  post 'comments' => 'comments#create'
  get 'comments/:id' => 'comments#index'
  post 'comments/:id/edit' => 'comments#edit'
  delete 'comments/:id' => 'comments#destroy'

  root 'home#index'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):

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
  