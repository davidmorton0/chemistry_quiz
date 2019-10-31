Rails.application.routes.draw do
  get 'users/new'
  root 'chem_pages#home'
  get '/home', to: 'chem_pages#home'
  get '/help', to: 'chem_pages#help'
  get '/about', to: 'chem_pages#about'
  get '/contact', to: 'chem_pages#contact'
  get  '/signup',  to: 'users#new'
end

