Rails.application.routes.draw do
  # devise_for :users
  # root 'pages#index'
  # get 'pages/show'

  get 'notes/index'
  # APIを定義
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :notes, only: [:index, :create, :update, :destroy] do
        collection do
          # メモを削除（ゴミ箱に移動）
          post '/trash', to: 'notes#throwAway'
          get 'search'
        end
      end
      resources :labels, only: [:index, :create, :update, :destroy]
    end
  end
end
