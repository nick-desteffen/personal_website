PersonalWebsite::Application.routes.draw do

  ## User session
  get "login" => "sessions#new", :as => "new_session"
  post "login" => "sessions#create", :as => "create_session"
  delete "logout" => "sessions#destroy", :as => "destroy_session"

  ## Contact form
  get "contact" => "contact_messages#new", :as => "contact"
  post "contact" => "contact_messages#create", :as => "create_contact_message"

  ## Resume
  get "resume" => "resume#index", :as => "resume_download"

  ## Blog
  get "blog(/page/:page)" => "posts#index", :as => "blog"
  get "blog/admin" => "posts#admin_index", :as => "admin_index"
  get "blog/new" => "posts#new", :as => "new_post"
  post "blog/new" => "posts#create", :as => "create_post"
  get "blog/:post_id/edit" => "posts#edit", :as => "edit_post"
  put "blog/:post_id/edit" => "posts#update", :as => "update_post"
  get "blog/:post_id" => "posts#show", :as => "blog_post"

  ## Comments
  post "blog/:post_id/comments/create" => "comments#create", :as => "create_comment"
  post "blog/:post_id/comments/:comment_id/spam" => "comments#flag_spam", :as => "flag_spam"
  get "blog/:post_id/comments/:comment_id/edit" => "comments#edit", :as => "edit_comment"
  patch "blog/:post_id/comments/:comment_id/edit" => "comments#update", :as => "update_comment"
  post "blog/comments/preview" => "comments#preview", :as => "preview_comment"
  delete "blog/:post_id/comments/:comment_id/destroy" => "comments#destroy", as: :destroy_comment

  ## Home
  get "/about" => "home#about", :as => "about"
  get "/home" => "home#index", :as => "home"

  ## Root
  root :to => 'posts#index'

end
