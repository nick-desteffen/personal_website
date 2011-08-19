class Post < ActiveRecord::Base
  extend FriendlyId
  
  default_scope :order => "created_at DESC"
  
  has_many :comments, :dependent => :destroy
  has_many :related_links, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  
  validates_presence_of :title, :body
  
  friendly_id :title, :use => :slugged
  
end
