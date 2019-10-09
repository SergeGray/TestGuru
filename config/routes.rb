Rails.application.routes.draw do
  root 'tests#index'

  get :registration, to: 'users#new'
  get :login, to: 'sessions#new'
  delete :logout, to: 'sessions#destroy'

  resources :users, only: :create
  resources :sessions, only: :create

  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    post :start, on: :member
  end

  resources :attempts, only: %i[show update] do
    get :result, on: :member
  end
end
