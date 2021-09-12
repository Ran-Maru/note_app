Rails.application.routes.draw do
  # devise_for :users
  # root 'pages#index'
  # get 'pages/show'

  # APIを定義
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :notes
    end
  end
end
