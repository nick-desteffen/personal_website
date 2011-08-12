PersonalWebsite::Application.routes.draw do
  
  get "contact" => "contact_messages#new", :as => "contact"
  post "contact" => "contact_messages#create", :as => "create_contact_message"

  root :to => 'home#index'

end
