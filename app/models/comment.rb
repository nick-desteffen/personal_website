class Comment < ActiveRecord::Base
  include Rakismet::Model
  
  default_scope :order => "created_at ASC"
  
  belongs_to :post
  
  attr_accessible :email, :name, :body, :url, :post_id
  
  before_validation :generate_gravatar_hash
  after_create :spam_check

  store :request, accessors: [:remote_ip, :user_agent, :referrer]

  rakismet_attrs author: :name, author_email: :email, author_url: :url, content: :body, user_ip: :remote_ip, user_agent: :user_agent, referrer: :referrer

  validates_presence_of :body, :name
  validates_format_of :email, :with => EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN, :allow_blank => true
  validates_format_of :url, :with => URI::regexp(%w(http https)), :allow_blank => true, :message => "should be fully qualified."
  
  scope :not_spam, where(:spam_flag => false)
  
  def http_request=(http_request)
    request[:remote_ip] = http_request.remote_ip
    request[:user_agent] = http_request.env['HTTP_USER_AGENT']
    request[:referrer] = http_request.env['HTTP_REFERER']
  end

  def flag_spam!
    update_attribute(:spam_flag, true)
  end
  
  private
  
  def generate_gravatar_hash
    if email.present?
      hash = Digest::MD5.hexdigest(email)
      write_attribute(:gravatar_hash, hash)
    end
  end

  def spam_check
    flag_spam! if spam?
  end
    
end
