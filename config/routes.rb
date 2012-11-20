# encoding: UTF-8
EcolevinetWebsite::Application.routes.draw do
  get "agenda/index"

  resources :portfolio
  resources :events do
    collection do
      get 'on_the'
      get 'for_the'
    end
  end

  match 'send/demande_absence'            => 'send#demande_absence'
  match 'send/justification_absence'      => 'send#justification_absence'
  match 'send/resultat_demande'           => 'send#resultat_demande'
  match 'send/resultat_justification'     => 'send#resultat_justification'
  match 'send/demande_contact'            => 'send#demande_contact'
  match 'send/demande_contact_homepage'   => 'send#demande_contact_homepage'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  get 'refinery', :to => 'Pages#home' #redirect refinery page to homepage
  get 'admin',    :to => 'admin/pages#index', :as => :refinery_root #uses /admin as the admin page
  get 'galerie',  :to => 'Portfolio#index'

end
