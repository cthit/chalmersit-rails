Rails.application.routes.draw do

  resources :user_group_infos
  get 'calendar/fetch'

  resources :menu_links
  resources :menus
  resources :sponsors
  resources :banners

  # Redirects (necessary due to menu system only allowing inbound links)
  get 'redirect/findit' => 'redirect#findit'
  get 'redirect/courses' => 'redirect#courses'

  resources :uploads, only: [:create, :destroy]
  patch '/uploads.json', to: 'uploads#create'

  get 'twitter/feed/:twitter_handle' => 'twitter#feed'

  post 'preview' => 'preview#preview'

  get 'pages/:id/delete_document/:document_name', to: 'pages#delete_document', as: :delete_page_document
  get 'posts/:id/delete_document/:document_name', to: 'posts#delete_document', as: :delete_post_document

  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  get 'signout' => 'sessions#destroy', as: :signout


  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :committees, :contact

    resources :pages
    resources :posts do
      resources :comments, only: [:create, :update, :destroy]
    end
    resources :business, only: [:index]
    get 'lunch/feed/(*filter)' => 'lunch#feed'
    get 'feed' => 'posts#index', defaults: { format: :rss }, as: :feed

    get 'search' => 'search#index', as: :search

    get 'print' => 'print#new', as: :new_print

    get 'frontpage/edit' => 'frontpage#edit', as: :edit_frontpage
    patch 'frontpage/update' => 'frontpage#update'
    put 'fronpage/update' => 'frontpage#update'

    root 'home#index'
    get '*path' => 'pages#show'
  end
end
