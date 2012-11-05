class Post < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  extend FriendlyId
  include PgSearch

  default_scope :order => "published_at DESC"
  
  has_many :comments, :dependent => :destroy
  has_many :related_links, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  
  validates_presence_of :title, :body
  
  accepts_nested_attributes_for :related_links, :tags, :allow_destroy => true
  
  friendly_id :title, :use => :slugged
  
  scope :published, lambda { where('posts.published_at < ?', Time.now) }

  pg_search_scope :search, against: [:body, :title], using: {tsearch: {dictionary: "english", prefix: true}}
  multisearchable against: [:title, :body]
  
  def tags_joined
    tags.alphabetized.map(&:name).join(", ")
  end

  def post
    self
  end
  
end
