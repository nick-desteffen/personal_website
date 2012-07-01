class Tag < ActiveRecord::Base
  
  belongs_to :post
  
  validates_presence_of :name

  attr_accessible :name
  
  scope :alphabetized, :order => :name
  
end
