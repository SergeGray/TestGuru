Rails.application.routes.draw do
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
