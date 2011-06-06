Rails.application.routes.draw do

  scope Contentr.frontend_route_prefix, :module => 'contentr' do
    # Render frontend pages
    get '/(*path)' => 'pages#show', :as => 'contentr'
  end

  namespace :contentr do
    namespace :admin do
      resources :contentr_pages do
        put 'reorder/:buddy_id', :on => :member, :action => :reorder
        resources :contentr_paragraphs
      end
    end
  end

end
