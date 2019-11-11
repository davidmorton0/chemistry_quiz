Rails.application.routes.draw do
  get 'sessions/new'
  root 'chem_pages#home'                    #main page - static
  get '/help', to: 'chem_pages#help'        #help page - static
  get '/about', to: 'chem_pages#about'      #about page - static
  get '/contact', to: 'chem_pages#contact'  #contact page - static
  get  '/signup',  to: 'users#new'          #sign up form for new users - static
  post '/signup',  to: 'users#create'       #posts to users to create new user then redirects to user page
  get '/quiz', to: 'quizzes#show'           #goes to current quiz for user
  post '/quiz', to: 'quizzes#new'           #creates a new quiz then redirects to it
  get    '/login',   to: 'sessions#new'     #login page
  post   '/login',   to: 'sessions#create'  #logs in
  delete '/logout',  to: 'sessions#destroy' #logs out
  resources :users, only: [ #:index,         #index page of all users - admin - not implemented
                            #:new,           #uses get signup instead
                            :create,        #uses post signup instead
                            :show,          #shows a user - needs change to show current user only
                            #:edit,          #form to edit current user - not implemented
                            #:update,        #post to update current user - not implemented
                            #:destroy       #deletes user - admin - not implemented
                          ]
  resources :quizzes, only: [ #:index,      #not needed
                            :new,           #makes new quiz - maybe change to create
                            #:create,
                            :show,
                            #:edit,         #not needed
                            #:update,       #not needed       
                            #:destroy       #not needed
                            ]
  resources :questions, only: [ :index,
                                #:new,
                                #:create,
                                :show,
                                #:edit,
                                #:update,
                                #:destroy
                              ]
end