class RelatedLink < ActiveRecord::Base
  
  belongs_to :post
  
  validates_format_of :url, :with => URI::regexp(%w(http https)), :allow_blank => false, :message => "should be fully qualified."
  
end
