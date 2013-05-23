class Comment < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Rakismet::Model
  include PgSearch

  default_scope :order => "created_at ASC"

  belongs_to :post

  before_validation :generate_gravatar_hash
  after_create :notify_me
  after_create :notify_commenters

  store :request, accessors: [:remote_ip, :user_agent, :referrer]

  rakismet_attrs author: :name, author_email: :email, author_url: :url, content: :body, user_ip: :remote_ip, user_agent: :user_agent, referrer: :referrer

  validates_presence_of :body, :name
  validates_format_of :email, :with => EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN, :allow_blank => true
  validates_format_of :url, :with => URI::regexp(%w(http https)), :allow_blank => true, :message => "should be fully qualified."
  validate :spam_check

  scope :not_spam, -> { where(spam_flag: false) }
  scope :notify,   -> { where(new_comment_notification: true) }

  pg_search_scope :search, against: [:body, :name], using: {tsearch: {dictionary: "english", prefix: true}}
  multisearchable against: [:name, :body]

  def http_request=(http_request)
    request[:remote_ip] = http_request.remote_ip
    request[:user_agent] = http_request.env['HTTP_USER_AGENT']
    request[:referrer] = http_request.env['HTTP_REFERER']
  end

  def flag_spam!
    self.spam_flag = true
    self.save
    spam!
  end

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

  def spam_check
    if spam?
      errors.add(:base, "Sorry, but this comment appears to be spam. If it is not spam please use the contact form.")
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
