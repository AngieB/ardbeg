Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  namespace :api, format: :json do
    resources :posts
  end

  root 'welcome#index'
end
