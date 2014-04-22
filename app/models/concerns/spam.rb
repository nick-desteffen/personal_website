module Spam
  extend ActiveSupport::Concern

  included do
    include Rakismet::Model

    store :request, accessors: [:remote_ip, :user_agent, :referrer]
    scope :not_spam, -> { where(spam_flag: false) }
    validate :spam_check
  end

  def http_request=(http_request)
    request[:remote_ip]  = http_request.remote_ip
    request[:user_agent] = http_request.env['HTTP_USER_AGENT']
    request[:referrer]   = http_request.env['HTTP_REFERER']
  end

  def flag_spam!
    self.spam_flag = true
    self.save
    spam!
  end

private

  def spam_check
    if spam?
      errors.add(:base, "Sorry, but this appears to be spam. Please try harder.")
    end
  end

end
