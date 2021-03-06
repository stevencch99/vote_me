Rails.application.routes.draw do
  # this line was generated by 'rails_admin' gem
  mount RailsAdmin::Engine => '/backend', as: 'rails_admin'
  
  devise_for :users
  # rails 3 舊寫法
  # get '/', controller: 'pages', action: 'home'

  # get '/', to: 'pages#home'
  # 改將首頁設定為 candidates#index
  root 'candidates#index'
  # 限制前台網址
  # resources :candidates, only: [:index, :show, :vote] do
  resources :candidates do
    member do
      patch :vote
    end
  end

  # 定義後台網址： /admin/candidates...
  namespace :admin do
    root 'pages#index'
    resources :candidates
  end

  # 較長的寫法（直接寫路徑）：
  # patch '/candidates/:id/vote', to: 'candidates#vote'
  
  get '/history', to: 'users#history'

  resources :products
  resource :cart, only: [:show, :destroy] do
    collection do
      put :add, path: 'add/:id'
    end
  end

end
