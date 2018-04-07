ShoppyCartus::Engine.routes.draw do
  resources :orders do
    get '/confirm/:token', to: 'orders#confirm', as: 'confirm'
  end
  resources :order_steps, only: %i[index show update]
  resources :order_items, except: %i[new edit show]
  resources :coupons, only: %i[create destroy]
end
