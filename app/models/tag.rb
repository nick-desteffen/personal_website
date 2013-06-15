class Tag < ActiveRecord::Base

  belongs_to :post

  validates_presence_of :name

  scope :alphabetized, -> { order(:name) }

end
