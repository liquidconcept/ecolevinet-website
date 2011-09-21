::Refinery::Application.routes.draw do
  resources :sections, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :sections, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
