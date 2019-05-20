Rails.application.routes.draw do
  # rails 3 舊寫法
  # get '/', controller: 'pages', action: 'home'

  # get '/', to: 'pages#home'
  # 改將首頁設定為 candidates#index
  root 'candidates#index'
  resources :candidates
end
