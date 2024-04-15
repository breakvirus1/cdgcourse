Rails.application.routes.draw do
  get 'relationships/new'
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  # get 'users/update'
  # get 'users/destroy'
  # devise_for :users, path: "", path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }

  devise_for :users do
    as :user do
      get 'signin', to: 'devise/sessions#new', as: :new_user_session
      post 'signin', to: 'devise/sessions#create', as: :user_session
      get '/users/sign_out' => 'devise/sessions#destroy'
      match '/users/:username', to: 'users#show', via: 'get'
    end
    authenticated :user do
      root 'blogs#index', as: :authenticated_root
    end
    unauthenticated do
      # root 'devise/sessions#create', as: :new_user_registration
      root 'Devise::RegistrationsController#new', as: :unauthenticated_root
    end
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'users/:id', to: 'users#show', as: 'user_profile'
  get 'about-me', to: 'pages#about'
  root to: 'blogs#index'
  resources :blogs do
    resources :comments, only: [:create]
    member do
      get :get_comments
    end
  end

  resources :users do
    member do
      post 'follow', to: 'users#follow', as: 'follow'
      delete 'unfollow', to: 'users#unfollow', as: 'unfollow'
    end
  end

  resources :users do
    member do
      post :follow
      delete :unfollow
    end
  end


  resources :blogs do
    member do
      post 'like', to: 'blogs#like'
      delete 'unlike', to: 'blogs#unlike'
    end
  end

  resources :users do
    post 'create_blog', to: 'users#create_blog', as: :user_blogs
  end
end
