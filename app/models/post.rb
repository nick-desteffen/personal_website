class Post < ActiveRecord::Base
  
  has_many :comments
  
  validates_presence_of :title, :body
  
  has_friendly_id :title, :use_slug => true
  
end
