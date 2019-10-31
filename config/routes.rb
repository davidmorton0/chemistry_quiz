Rails.application.routes.draw do
  get 'chem_pages/home'
  get 'chem_pages/help'
  root 'application#hello'
end
