class Post < ActiveRecord::Base
  extend FriendlyId
  
  default_scope :order => "published_at DESC"
  
  has_many :comments, :dependent => :destroy
  has_many :related_links, :dependent => :destroy
  has_many :tags, :dependent => :destroy

  attr_accessible :title, :body
  
  validates_presence_of :title, :body
  
  accepts_nested_attributes_for :related_links, :tags, :allow_destroy => true
  
  friendly_id :title, :use => :slugged
  
  scope :published, lambda { where('posts.published_at < ?', Time.now) }
  
  def tags_joined
    tags.alphabetized.map(&:name).join(", ")
  end
  
end
