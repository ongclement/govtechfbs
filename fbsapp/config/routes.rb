Rails.application.routes.draw do
    get 'welcome/index'

    resource :users
    resource :rooms
    resource :bookings

    root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
