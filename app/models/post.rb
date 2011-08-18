class Post < ActiveRecord::Base
  extend FriendlyId
  
  has_many :comments
  
  validates_presence_of :title, :body
  
  friendly_id :title, :use => :slugged
  
end
