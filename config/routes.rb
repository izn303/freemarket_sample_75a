Rails.application.routes.draw do
  get 'buyers/index'
  get 'buyers/done'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end

  root 'items#index'
  get "users/signout"
  get "items/edit"
  get "cards/menu"

  resources :items do
    collection do
      get 'category_children', defaults: { format: 'json'}
      get 'category_grandchildren', defaults: { format: 'json'}
    end
    resources :image

    resources :buyers, only: [:index] do
      collection do
        get 'done', to: 'buyers#done'
        post 'pay', to: 'buyers#pay'
      end
    end
  end

  resources :users, only: [:new, :create, :show, :destroy]
  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
      post 'show', to: 'card#show'
      post 'delete', to: 'card#delete'
    end
  end
end
