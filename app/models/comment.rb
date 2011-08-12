class Comment < ActiveRecord::Base
  
  belongs_to :post
  
  before_validation :generate_gravatar_url
  
  private
  
  def generate_gravatar_url
  end
  
end
