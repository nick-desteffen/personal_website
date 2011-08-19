class Comment < ActiveRecord::Base
  
  default_scope :order => "created_at ASC"
  
  belongs_to :post
  
  attr_accessible :email, :name, :body, :url
  
  before_validation :generate_gravatar_hash
  
  validates_presence_of :body, :name
  validates_format_of :email, :with => EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN, :allow_blank => true
  validates_format_of :url, :with => URI::regexp(%w(http https)), :allow_blank => true, :message => "should be fully qualified."
  
  private
  
  def generate_gravatar_hash
    if email.present?
      hash = Digest::MD5.hexdigest(email)
      write_attribute(:gravatar_hash, hash)
    end
  end
  
end
