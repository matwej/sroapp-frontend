# -*- encoding : utf-8 -*-
Rails.application.routes.draw do

  get 'sro/show'
  get 'sro/create'
  
  get 'main/show_prof'
  get 'main/edit_prof'
  get 'main/cr_prof'

  get 'main/welcome'
  get 'main/index'
  
  get 'main/register'
  get 'main/login'
  get 'main/logout'
  
  post 'main/cr_acc'
  post 'main/create_profile'
  post 'main/action_login'
  post 'main/delete_prof'
  patch 'main/action_edit_prof'
  post 'main/edit_user_email'
  post 'main/edit_user_pass'
  
  delete 'sro/delete'
  post 'sro/step12'
  get 'sro/step2'
  patch 'sro/step23'
  get 'sro/step3'
  patch 'sro/step34'
  get 'sro/step4'
  patch 'sro/step45'
  get 'sro/step5'
  patch 'sro/step56'
  get 'sro/step6'
  patch 'sro/step67'
  get 'sro/step7'
  post 'sro/step78'
  get 'sro/step8'
  
  resources :people, :only => [:destroy, :create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#welcome'

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
