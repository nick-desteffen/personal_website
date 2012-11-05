class Tag < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
    
  belongs_to :post
  
  validates_presence_of :name
  
  scope :alphabetized, :order => :name
  
end
