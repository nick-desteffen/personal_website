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
    update_column(:spam_flag, true)
    spam!
  end

private

  def spam_check
    begin
      if spam?
        errors.add(:base, "Sorry, but this appears to be spam. Please try harder.")
      end
    rescue Net::ReadTimeout => exception
      ## NOOP
    end
  end

end
