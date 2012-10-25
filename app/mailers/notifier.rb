class Notifier < ActionMailer::Base
  
  layout "application_mailer"
  
  default from: "nick.desteffen@gmail.com"
  default to: "nick.desteffen@gmail.com"
    
  def new_contact_message(contact_message)
    @contact_message = contact_message
    mail(subject: contact_message.subject)
  end

  def new_comment(post, recipient_email_address, recipient_name)
    @post = post
    @recipient_name = recipient_name
    mail(to: recipient_email_address, subject: "New comment posted on: #{post.title}")
  end
  
end
