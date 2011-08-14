class Comment < ActiveRecord::Base
  
  belongs_to :post
  
  before_validation :generate_gravatar_url
  
  validates_presence_of :body, :name
  ## Validate email format
  
  private
  
  def generate_gravatar_url
    #require 'digest/md5'
    hash = Digest::MD5.hexdigest(email)
    write_attribute(:gravatar_url, "http://www.gravatar.com/avatar/#{hash}")
  end
  
end
