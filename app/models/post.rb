class Post < ActiveRecord::Base
  extend FriendlyId
  
  default_scope :order => "created_at DESC"
  
  has_many :comments, :dependent => :destroy
  has_many :related_links, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  
  validates_presence_of :title, :body
  
  accepts_nested_attributes_for :related_links, :tags, :allow_destroy => true
  
  friendly_id :title, :use => :slugged
  
  def tags_joined
    tags.map(&:name).join(", ")
  end
  
end
