Rails.application.routes.draw do
    get 'welcome/index'

    get     '/login',   to: 'sessions#new'
    post    '/login',   to: 'sessions#create'
    delete  '/logout',  to: 'sessions#destroy'

    get     '/bookings/editstatus/:id/:status',  to: 'bookings#editStatus'
    get     '/rooms/save_details/:id/:name/:desc' => 'rooms#save_details', :as => 'save_details'

    resources :users
    resources :rooms do
        get 'save_details', on: :collection
    end
    resources :bookings

    root 'sessions#new'

    # IMPORTANT! This line must be read last and no routes should be below this
    get '*path' => redirect('/')
end
