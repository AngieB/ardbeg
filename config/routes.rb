Rails.application.routes.draw do
  namespace :api do
    resources :posts
  end
  
  root 'welcome#index'
end
