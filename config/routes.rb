Rails.application.routes.draw do
  shallow do
    authenticate :user do
      root 'dashboard#index'
    end

    devise_for :users

    authenticate :user do
      resources :users, only: [:update]
    end
  end
end
