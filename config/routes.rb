Rails.application.routes.draw do

  get 'pages/textshare'

  devise_for :users, controllers: { sessions: 'plock' }
  get 'pages/scolasindex'

  resources :listings do
    collection do
      get "search"
    end
  end

  resources :transactions   , only: [:create]
  resources :archives       , only: [:create]
  resources :rooms          , only: [:show, :create]
  resources :messages       , only: [:create]

  resources :post do
    resources :comment do
      resources :reply, except: [:new]
    end
  end

  resources :subject, only: [:index, :create] do
    collection do
      get "search"
    end
  end

  resources :interest do
    collection do
      get "search"
    end
  end
  
  resources :editinterest
  resources :users

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  get "pages/about"
  get "pages/contact"
  get 'seller' => "listings#seller"

  get "purchasing"  => "transactions#purchasing"
  get "sell"      => "transactions#sell"

  get "purchased"  => "archives#purchased"
  get "sales"      => "archives#sales"

  root 'pages#scolasindex'

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
