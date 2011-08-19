class RelatedLink < ActiveRecord::Base
  
  belongs_to :post
  
  validates_format_of :url, :with => URI::regexp(%w(http https)), :allow_blank => false, :message => "should be fully qualified."
  
  def title
    read_attribute(:title) || read_attribute(:url)
  end
  
end
