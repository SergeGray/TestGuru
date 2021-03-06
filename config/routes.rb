Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :tests, only: :index do
    post :start, on: :member
  end

  resources :attempts, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    
    resources :badges
    resources :gists, only: :index
  end

  resources :feedback, only: %i[new create]
  resources :badges, only: %i[index show]
end
