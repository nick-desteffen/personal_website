class Comment < ActiveRecord::Base
  include Spam
  include PgSearch

  default_scope -> { order("created_at ASC") }

  belongs_to :post

  before_validation :generate_gravatar_hash
  after_create :notify_me
  after_create :notify_commenters

  rakismet_attrs author: :name, author_email: :email, author_url: :url, content: :body, user_ip: :remote_ip, user_agent: :user_agent, referrer: :referrer

  validates_presence_of :body, :name
  validates_format_of :email, with: Rails.configuration.email_validation_regex, allow_blank: true
  validates_format_of :url, with: URI::regexp(%w(http https)), allow_blank: true, message: "should be fully qualified."

  scope :notify, -> { where(new_comment_notification: true) }

  pg_search_scope :search, against: [:body, :name], using: {tsearch: {dictionary: "english", prefix: true}}
  multisearchable against: [:name, :body]

  def self.preview(params)
    comment = Comment.new(params)
    comment.created_at = Time.now
    comment.valid?
    comment
  end

private

  def generate_gravatar_hash
    if email.present?
      hash = Digest::MD5.hexdigest(email)
      write_attribute(:gravatar_hash, hash)
    end
  end

  def notify_commenters
    post.comments.notify
      .reject{ |comment| comment == self || comment.email.blank? }
      .collect{ |comment| {name: comment.name, email: comment.email} }
      .uniq
      .each{ |recipient| Notifier.new_comment(post, recipient[:email], recipient[:name]).deliver }
  end

  def notify_me
    Notifier.new_comment(self.post, "nick.desteffen@gmail.com", "Nick").deliver
  end

end
