Rails.application.routes.draw do
  root 'chem_pages#home'                    #main page - static
  
  get '/quiz', to: 'quizzes#show'        #goes to current quiz for user or redirects to choose quiz if none
  patch '/quiz', to: 'quizzes#update'     #answers questions on a quiz
  
  get 'password_resets/new'
  get 'password_resets/edit'
  
  get '/help', to: 'chem_pages#help'        #help page - static
  get '/about', to: 'chem_pages#about'      #about page - static
  get '/contact', to: 'chem_pages#contact'  #contact page - static
  get  '/signup',  to: 'users#new'          #sign up form for new users - static
  post '/signup',  to: 'users#create'       #posts to users to create new user then redirects to user page
  
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'     #login page
  post   '/login',   to: 'sessions#create'  #logs in
  delete '/logout',  to: 'sessions#destroy' #logs out
  resources :users, only: [ :index,         #index page of all users - admin
                            #:new,           #uses get signup instead
                            #:create,        #uses post signup instead
                            :show,          #shows a user - needs change to show current user only
                            :edit,          #form to edit current user
                            :update,        #post to update current user
                            :destroy        #deletes user - admin
                          ]
  
  resources :questions, only: [ :index,   #shows all questions - admin
                                #:new,
                                #:create,
                                :show,    #shows a question - admin
                                #:edit,
                                #:update,
                                #:destroy
                              ]
  resources :account_activations, only: [ :edit]
  resources :password_resets,     only: [ :new,  :create, :edit, :update]
  resources :quiz_types,          only:  [  :index, #choose quiz page
                                            :show]  #creates chosen quiz and redirects to quiz page
end