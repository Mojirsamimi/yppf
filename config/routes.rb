Rails.application.routes.draw do
  get 'home' => 'home#new'

  get 'expense_categories/new'

  get 'expense_categories/create'

  get 'expense_categories/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'

  resources :users
  resources :expenses do
    resources :expense_details
  end
  resources :bills
  get 'bills/cal/new' => 'bills#calnew'
  post 'bills/create' => 'bills#create'
  resources :incomes
  post 'expense_references/createrecurrent' => 'expense_references#createrecurrent'
  post 'expense_references/createone' => 'expense_references#createone'
  get 'expense_references/newone' => 'expense_references#newone'
  resources :expense_references
  get 'expense_references/allinone/new' => 'expense_references#allinonenew'
  get 'expense_references/justgeneral/new' => 'expense_references#justgeneral'
  post 'expense_references/create' => 'expense_references#create'


  root 'home#new'
  #root to: 'pages#index'
  #Expense Reference

  #get 'manageexpenses/index' => 'expense_references#index'

  get 'dashboard/new' => 'dashboard#new'
  get 'datas/add' => 'datas#add'
  get 'incomes/new' => 'incomes#new'
  get 'expenses/new' => 'expenses#new'
  get 'bills/new' => 'bills#new'
  get 'budgets/display' => 'budgets#display'
  get 'calendar/new' => 'calendar#new'

  get 'compare/new' => 'compare#new'
  get 'compare/create' => 'compare#create'

  get 'trend/new' => 'trend#new'
  get 'trend/barchart' => 'trend#barchart'

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
