::Refinery::Application.routes.draw do
  resources :news_items, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :news_items, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
