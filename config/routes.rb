Rails.application.routes.draw do
 
  namespace :admin do
    resources :catalogues
  end
  resources :catalogues
  namespace :admin do
    resources :products
  end
  resources :products
   
  namespace :admin do
    resources :invoices
  end
  resources :invoices
   
  namespace :admin do
    resources :articles
  end
  resources :articles
  namespace :admin do
    resources :portfolios
  end
  resources :portfolios
  namespace :admin do
    resources :resources
  end
  resources :resources
   
  namespace :admin do
    resources :pages
  end
  resources :pages
  namespace :admin do
    resources :users
  end
  resources :users
  namespace :admin do
    resources :options
  end
  resources :options

  namespace :admin do
    resources :helps
  end

  namespace :admin do
    resources :home
  end
   # api
  get 'api/account/register' => 'api#register'
  get 'api/account/updateuser' => 'api#updateuser'
  get 'api/account/login' => 'api#login'
  get 'api/account/forgetpassword' => 'api#forgetpassword'
  get 'api/content/page' => 'api#page'
  get 'api/content/option' => 'api#option'
  get 'api/sendmails' => 'api#sendmails'
  get 'api/product' => 'api#product'
  get 'api/catalogs' => 'api#catalogs' 
  get 'api/cataloglist' => 'api#cataloglist' 

  # end api   
  get 'sessions/new'  
  get 'sessions/create'
  get 'sessions/destroy'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'  
  root 'pages#homepage'    # make index homepage  
  resources 'contactus' , to: 'pages#contactus' , as:'contactus'
  # root 'admin/pages#index'    make index in sub forlder   
  # root :to => "pages#show", :id => '1'   make index page
  get 'admin', to: 'admin/home#index', as: 'admin' # make index home admin
  # popup choose image  
  get 'admin/resources/popup/image', to: 'admin/resources#popup', as: 'admin/resources/popup/image'
  #slice more router option 
  get 'admin/options/config/mailserver', to: 'admin/options#mailconfig', as: 'admin/options/config/mailserver'
  # write url portfolio
  get 'portfolios/:id/:title' => 'portfolios#show', :as => :portfolios_with_title
  get 'page/:id' => 'pages#show', :as => :page_with_url
  get ':title/:id' => 'pages#show', :as => :pages_with_url
  get ':title/:title/:id' => 'pages#show', :as => :pagess_with_url
  get 'page/:title/:title/:title/:id' => 'pages#show', :as => :pagesss_with_url
  get 'page/:title/:title/:title/:title/:id' => 'pages#show', :as => :pagessss_with_url
  get 'catalogs/:id' => 'catalogues#show', :as => :catalog_with_url
  get 'catalogs/:title/:id' => 'catalogues#show', :as => :catalogs_with_url
  get 'catalogs/:title/:title/:id' => 'catalogues#show', :as => :catalogss_with_url
  get 'catalogs/:title/:title/:title/:id' => 'catalogues#show', :as => :catalogsss_with_url
  get 'catalogs/:title/:title/:title/:title/:id' => 'catalogues#show', :as => :catalogssss_with_url
  
  #get 'welcome-message' => 'pages#show' , :id => '1'
  get 'about-us' => 'pages#show' , :id => '19'
  get 've-chung-toi' => 'pages#show' , :id => '19'
  get 'solutions' => 'pages#show' , :id => '23'
  get 'giai-phap' => 'pages#show' , :id => '23'
  resources 'getpass', to: 'users#getpass', as: 'getpass'
  get 'newpass', to: 'users#newpass', as: 'newpass'  
  get 'admin/options/plugin/:action'  => 'admin/options#:action', :as => :opt_plugin
  get ':action'  => 'pages#:action', :as => :page_view

  # post 'facebook', to: 'sessions#facebook', as: 'facebook' 
  # get 'mail', to:  redirect("https://mail.xxx.com")
       
end


