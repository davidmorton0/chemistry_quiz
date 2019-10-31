Rails.application.routes.draw do
  root 'chem_pages#home'
  get 'chem_pages/home'
  get 'chem_pages/help'
  get 'chem_pages/about'
end
