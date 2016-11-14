Rails.application.routes.draw do

  get 'calendar/fetch'

  resources :menu_links
  resources :menus
  resources :sponsors

  # Redirects (necessary due to menu system only allowing inbound links)
  get 'redirect/findit' => 'redirect#findit'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :committees, :contact

    resources :pages
    resources :posts do
      resources :comments, only: [:create, :update, :destroy]
    end

    get 'lunch/feed/' => 'lunch#feed'
    get 'feed' => 'posts#index', defaults: { format: :rss }, as: :feed

    get 'search' => 'search#index', as: :search

    get 'print' => 'print#new', as: :new_print
    post 'print' => 'print#print', as: :prints
    post 'print/pq' => 'print#pq', as: :pq_print

    resources :courses do
        member do
          get 'site'
        end
    end

    root 'home#index'
  end
  resources :uploads, only: [:create, :destroy]

  get 'twitter/feed/:twitter_handle' => 'twitter#feed'

  post 'preview' => 'preview#preview'

  get 'pages/:id/delete_document/:document_name', to: 'pages#delete_document', as: :delete_page_document
  get 'posts/:id/delete_document/:document_name', to: 'posts#delete_document', as: :delete_post_document
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  get 'signout' => 'sessions#destroy', as: :signout
  get '*path' => 'pages#show'
end
