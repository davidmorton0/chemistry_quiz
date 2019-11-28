Rails.application.routes.draw do
  get '/scores'  , to: 'scores#index'               # global high scores
  root 'chem_pages#home'                            # main page
  get '/quiz', to: 'quizzes#show'                   # current quiz for user or redirects to choose quiz if none
  patch '/quiz', to: 'quizzes#update'               # answers questions on a quiz
  get '/quiz_view/:id', to: 'quizzes#view',         # show selected quiz - admin
                        as: :quiz_view
  get '/help', to: 'chem_pages#help'                # help page
  get '/about', to: 'chem_pages#about'              # about page
  get '/contact', to: 'chem_pages#contact'          # contact page
  get  '/signup',  to: 'users#new'                  # sign up form for new users
  post '/signup',  to: 'users#create'               # posts to users to create new user then redirects to user page
  get    '/login',   to: 'sessions#new'             # login page
  post   '/login',   to: 'sessions#create'          # logs in
  delete '/logout',  to: 'sessions#destroy'         # logs out
  resources :users, only: [ :index,                 # index page of all users - admin
                            :show,                  # shows a user - needs change to show current user only
                            :edit,                  # form to edit current user
                            :update,                # post to update current user
                            :destroy ]              # deletes user - admin
  resources :quizzes, only: [ :index ]              # index of quizzes - admin
  resources :questions, only: [ :index,             # shows all questions - admin
                                :show ]             # shows a question - admin
  resources :account_activations, only: [ :edit ]   # link to activate account
  resources :password_resets,     only: [ :new,     # form for password reset
                                          :create,  # send password reset email
                                          :edit,    # form to change password after reset
                                          :update ] # change password after reset
  resources :quiz_types,          only: [ :index,   # choose quiz page
                                          :show ]   # creates chosen quiz and redirects to quiz page
end