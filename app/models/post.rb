class Post < ActiveRecord::Base
  extend FriendlyId
  
  has_many :comments
  has_many :related_links
  has_many :tags
  
  validates_presence_of :title, :body
  
  friendly_id :title, :use => :slugged
  
end
