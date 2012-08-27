class Notifier < ActionMailer::Base
  
  layout "application_mailer"
  
  default from: "nick.desteffen@gmail.com"
  default to: "nick.desteffen@gmail.com"
    
  def new_contact_message(contact_message)
    @contact_message = contact_message
    mail(subject: contact_message.subject)
  end

  def new_comment(comment)
    @comment = comment
    mail(to: comment.email, subject: "New comment posted on: #{comment.post.title}")
  end
  
end
