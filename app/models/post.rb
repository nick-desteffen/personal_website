class Post < ActiveRecord::Base
  include PgSearch

  default_scope -> { order(published_at: :desc) }

  has_many :comments, dependent: :destroy
  has_many :related_links, dependent: :destroy

  before_validation :generate_slug, on: :create

  validates_presence_of :title, :body

  accepts_nested_attributes_for :related_links, allow_destroy: true

  scope :published, -> { where('posts.published_at < ?', Time.now) }

  pg_search_scope :search, against: [:body, :title], using: {tsearch: {dictionary: "english", prefix: true}}
  multisearchable against: [:title, :body]

  def post
    self
  end

  def to_param
    slug
  end

private

  def generate_slug
    self.slug = title.try(:parameterize)
  end

end
