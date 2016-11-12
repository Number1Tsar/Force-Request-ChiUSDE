Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'movies#index'
  root 'student_requests#student_init'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  get 'student_requests/adminview' => 'student_requests#adminview'
  put 'student_requests/updaterequestbyadmin' => 'student_requests#updaterequestbyadmin'
  put 'student_requests/multiupdate' => 'student_requests#multiupdate'
  post 'student_requests/login' => 'student_requests#login'
  get 'student_requests/getSpreadsheet' => 'student_requests#getSpreadsheet'
  get 'student_requests/uin/:uin' => 'student_requests#getStudentInformationByUin'
  get 'student_requests/id/:id' => 'student_requests#getStudentInformationById'
  
  get 'student_requests/logout' => 'student_requests#logout'

  resources :student_requests
  
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
