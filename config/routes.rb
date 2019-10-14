Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users

  resources :tests, only: :index do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    post :start, on: :member
  end

  resources :attempts, only: %i[show update] do
    get :result, on: :member
  end

  namespace :admin do
    resources :tests
  end
end
