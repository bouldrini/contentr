Rails.application.routes.draw do

  # admin
  namespace :contentr do
    namespace :admin do
      resources :pages do
        put 'move_below/:buddy_id',        :on => :member, :action => :move_below
        put 'insert_into/(:root_page_id)', :on => :member, :action => :insert_into
      end

      resources :files

      put    'pages/:page_id/area/:area_name/paragraphs/reorder'     => 'paragraphs#reorder', :as => 'reorder_paragraphs'
      get    'pages/:page_id/area/:area_name/paragraphs/(:type)/new' => 'paragraphs#new',     :as => 'new_paragraph'
      post   'pages/:page_id/area/:area_name/paragraphs/:type'       => 'paragraphs#create',  :as => 'paragraphs'

      get    'pages/:page_id/paragraphs'           => 'paragraphs#index',   :as => 'page_paragraphs'
      get    'pages/:page_id/paragraphs/:id/edit'  => 'paragraphs#edit',    :as => 'edit_paragraph'
      put    'pages/:page_id/paragraphs/:id'       => 'paragraphs#update',  :as => 'paragraph'
      delete 'pages/:page_id/paragraphs/:id'       => 'paragraphs#destroy', :as => 'paragraph'
    end
  end

  # frontend
  get 'file/:slug' => 'contentr/files#show'
  get '*contentr_path' => 'contentr/pages#show', :as => 'contentr'
end
