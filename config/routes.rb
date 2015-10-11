Rails.application.routes.draw do
  get 'quiz/index'
  post 'quiz/determine_avatar' => 'quiz#determine_avatar'

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
