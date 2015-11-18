Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  
  namespace :api do
    resources :posts
  end

  root 'welcome#index'
end
