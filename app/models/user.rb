class User < ActiveRecord::Base

  has_secure_password

  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: EmailAddressValidation::EMAIL_ADDRESS_EXACT_PATTERN

  def full_name
    "#{first_name} #{last_name}"
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password, cost: Rails.configuration.password_cost)
    end
  end

end
