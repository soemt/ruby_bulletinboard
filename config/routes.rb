Rails.application.routes.draw do
  root 'posts#index'
  resources :users 
  resources :posts do
    collection do
      post :create_confirm
      get :create_confirm
      get :upload_csv
      post :import
    end
    member do
      post :update_confirm, to: "posts#update"
      get :update_confirm
    end
  end

  # log in page with form:
	get '/login'     => 'auth#login'
	post '/login'    => 'auth#create'
	delete '/logout' => 'auth#destroy' 

  # get 'users#profile'
  get 'users/:id/profile', to: 'users#profile', as: :profile
  
  # authentication
  get '/signup' => 'auth#signup'
  post '/signup' => 'auth#create_user', as: :new_account

  # password update
  get 'users/:id/change_password' => 'users#change_password', as: :change_password
  post 'users/:id/change_password' => 'users#update_password', as: :update_password
  
  # password reset
  get 'password/forgot' => 'password#forgot', as: :forgot
  get 'password/reset/:token' => 'password#reset', as: :reset
  post 'password/forgot' => 'password#forgot_pw'
  post 'password/reset/:token' => 'password#reset_password', as: :reset_password

  # download csv
  get 'download/posts' => 'posts#download', as: :download

end
