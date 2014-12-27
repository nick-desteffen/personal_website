class RelatedLink < ActiveRecord::Base

  belongs_to :post

  validates_format_of :url, with: URI::regexp(%w(http https)), allow_blank: false, message: "should be fully qualified."

  def title
    read_attribute(:title).present? ? read_attribute(:title) : url
  end

end
