Rails.application.routes.draw do
    get 'welcome/index'

    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'

    resources :users
    resources :rooms
    resources :bookings

    root 'sessions#new'

    # IMPORTANT! This line must be read last and no routes should be below this
    get '*path' => redirect('/')
end
