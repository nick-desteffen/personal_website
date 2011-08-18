PersonalWebsite::Application.routes.draw do
  
  get "contact" => "contact_messages#new", :as => "contact"
  post "contact" => "contact_messages#create", :as => "create_contact_message"
  
  get "resume" => "resume#index", :as => "resume_download"
  
  get "blog" => "posts#index", :as => "blog"
  get "blog/new" => "posts#new", :as => "new_post"
  post "blog/new" => "posts#create", :as => "create_post"
  get "blog/:post_id/edit" => "posts#edit", :as => "edit_post"
  put "blog/:post_id/edit" => "posts#update", :as => "update_post"
  get "blog/:post_id" => "posts#show", :as => "blog_post"
  
  post "blog/:post_id/comments/create" => "comments#create", :as => "create_comment"
  
  root :to => 'home#index'

end
