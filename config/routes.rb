Rails.application.routes.draw do
  root 'chem_pages#home'
  get '/help', to: 'chem_pages#help'
  get '/about', to: 'chem_pages#about'
  get '/contact', to: 'chem_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
  resources :quizzes
  resources :questions
end

