class ContactMessage < ActiveRecord::Base
  
  attr_accessible :email, :name, :phone_number, :subject, :message
  
  validates_presence_of :email, :name, :phone_number, :message
  validates_length_of :phone_number, :within => (10..11)
  validates_format_of :email, :with => EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN
  
  before_validation :sanitize_phone_number
  after_create :deliver_email_notification
  
  private
  
  def sanitize_phone_number
    write_attribute(:phone_number, phone_number.strip.gsub(/\D/, ""))
  end
  
  def deliver_email_notification
    Notifier.new_contact_message(self).deliver
  end
  
end
