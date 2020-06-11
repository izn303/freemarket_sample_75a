Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  
  root 'items#index'
  get "items/edit"


  resources :items do
    collection do
      get 'category_children', defaults: { format: 'json'}
      get 'category_grandchildren', defaults: { format: 'json'}
    end
    resources :image

    resources :cards, only: :purchase do
      collection do
        get "purchase"
        post "buy"
        get "done"
      end
    end
  end

  resources :users, only: [:new, :create, :show, :destroy]do
    collection do
      get "signout"
      delete 'destroy_all'
    end
  end

  resources :cards, only: [:new, :show]do
    collection do
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
      get "show"
      get "menu"
    end
  end

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'


end
