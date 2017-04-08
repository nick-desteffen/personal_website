class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  validates_presence_of :email
  validates_presence_of :password

  def authenticated?
    @user = User.find_by(email: email)
    return true if @user && @user.authenticate(password)
    return false
  end

  def user
    @user
  end

end
