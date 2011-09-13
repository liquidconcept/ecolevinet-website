::Refinery::Application.routes.draw do
  resources :actualites, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :actualites, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
