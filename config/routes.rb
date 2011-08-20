PersonalWebsite::Application.routes.draw do
  
  ## User session
  get "login" => "sessions#new", :as => "new_session"
  post "login" => "sessions#create", :as => "create_session"
  delete "logout" => "sessions#destroy", :as => "destroy_session"
  
  ## User registration
  get "users/register" => "users#new", :as => "new_user"
  post "users/register" => "users#create", :as => "create_user"

  ## Contact form
  get "contact" => "contact_messages#new", :as => "contact"
  post "contact" => "contact_messages#create", :as => "create_contact_message"
  
  ## Resume
  get "resume" => "resume#index", :as => "resume_download"
  
  ## Blog
  get "blog" => "posts#index", :as => "blog"
  get "blog/new" => "posts#new", :as => "new_post"
  post "blog/new" => "posts#create", :as => "create_post"
  get "blog/:post_id/edit" => "posts#edit", :as => "edit_post"
  put "blog/:post_id/edit" => "posts#update", :as => "update_post"
  get "blog/:post_id" => "posts#show", :as => "blog_post"
  post "blog/:post_id/comments/create" => "posts#create_comment", :as => "create_comment"
  
  ## Home
  get "/about" => "home#about", :as => "about"
  get "/home" => "home#index", :as => "home"
  
  ## Root
  root :to => 'posts#index'

end
