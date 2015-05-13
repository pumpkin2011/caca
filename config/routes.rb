Rails.application.routes.draw do


  get 'pages/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get '/profile'=> 'welcome#profile', as: :profile
  get '/profile/:id' => 'users#profile'
  post '/frozen' => 'welcome#frozen'
  get '/qiniu_token' => 'welcome#qiniu_token'
  get '/task' =>'tasks#my', as: :my_task

  resources :deposits, only: [:index, :create]
  resources :delivers do
    get 'apply', on: :collection
  end
  resources :wangwangs, only: [:index, :create]
  resources :shops, only: [:index, :create]
  resources :tasks do
    resources :orders, only: [:new, :create]
    patch 'validate', on: :member
  end

  resources :templates, only: [:index, :destroy, :create]
  resources :orders, only: [:index] do
    get 'reject', on: :member
    get 'confirm', on: :member
  end

  resource :authenticates, only:[:edit, :update]
  resources :pages, only: [:index, :show]

  namespace :admin do
    root 'welcome#index'
    resources :deposits, only: [:index, :create]
    resources :delivers, only: [:index] do
      get 'reject', on: :member
      get 'confirm', on: :member
    end

    resources :wangwangs, only: [:index] do
      get 'reject', on: :member
      get 'confirm', on: :member
    end

    resources :shops, only: [:index] do
      get 'reject', on: :member
      get 'confirm', on: :member
    end
    resources :users do
      get 'reject', on: :member
      get 'confirm', on: :member
      get 'official', on: :member
      get 'cancel_official', on: :member
    end

    resources :pages
  end

  devise_for :users, path: ''
  devise_for :admins, path: 'admin'

  mount ChinaCity::Engine => '/china_city'

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
