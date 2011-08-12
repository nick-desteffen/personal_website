class ContactMessage < ActiveRecord::Base
  
  validates_presence_of :email, :name, :phone_number, :message
  validates_length_of :phone_number, :within => (10..11)
  
  before_validation :sanitize_phone_number
  
  private
  
  def sanitize_phone_number
    write_attribute(:phone_number, phone_number.strip.gsub(/\D/, ""))
  end
  
end
