class Post < ActiveRecord::Base
  extend FriendlyId
  include PgSearch

  default_scope -> { order(published_at: :desc) }

  has_many :comments, dependent: :destroy
  has_many :related_links, dependent: :destroy

  validates_presence_of :title, :body

  accepts_nested_attributes_for :related_links, allow_destroy: true

  friendly_id :title, :use => :slugged

  scope :published, -> { where('posts.published_at < ?', Time.now) }

  pg_search_scope :search, against: [:body, :title], using: {tsearch: {dictionary: "english", prefix: true}}
  multisearchable against: [:title, :body]

  def post
    self
  end

end
