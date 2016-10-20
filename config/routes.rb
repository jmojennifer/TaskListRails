Rails.application.routes.draw do

  # new route for authorization

  root 'sessions#login'

  # new routes for OmniAuth

  get "/auth/:provider/callback" =>  "sessions#create"

  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"

  delete "sessions", to: "sessions#destroy"

  # I wouldn't have a root path anymore with resources, and my order isn't correct as-is. Many of my routes would not need adjustments, though ones relying on as: would need to be.

  # My differences are mostly because I have more specific prefix call-outs built into my routes than Rails provides. I do have a special custom route for completing my task, which resources would not provide. (My ordering as-is also needs improvement, and Rails can help with that.)

  # Project-as-submitted routes:

  get 'tasks' => 'tasks#index'
  get 'tasks/new' => 'tasks#new'
  post 'tasks' => 'tasks#create'
  get 'tasks/:id/edit', to: 'tasks#edit', as: 'task_edit'
  patch 'tasks/:id' => 'tasks#update'
  patch 'tasks/:id/complete' => 'tasks#complete', as: 'task_complete'
  delete 'tasks/:id' => 'tasks#destroy'
  get 'tasks/:id', to: 'tasks#show', as: 'task'

  # Refactor Attempt: Broke because I didn't have enough as: route name definitions to cover all needed routes

  # root 'tasks#index'
  # resources :routes, except: [:edit, :show]
  # get 'tasks/:id/edit', to: 'tasks#edit', as: 'task_edit'
  # patch 'tasks/:id/complete' => 'tasks#complete', as: 'task_complete'
  # get 'tasks/:id', to: 'tasks#show', as: 'task'
  # get 'tasks/:id', to: 'tasks#show', as: 'task'

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
