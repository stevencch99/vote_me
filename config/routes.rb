Rails.application.routes.draw do
  devise_for :users
  # rails 3 舊寫法
  # get '/', controller: 'pages', action: 'home'

  # get '/', to: 'pages#home'
  # 改將首頁設定為 candidates#index
  root 'candidates#index'
  resources :candidates do
    member do
      patch :vote
    end
  end

  # 較長的寫法（直接寫路徑）：
  # patch '/candidates/:id/vote', to: 'candidates#vote'
end
