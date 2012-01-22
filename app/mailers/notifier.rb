class Notifier < ActionMailer::Base
  
  layout "application_mailer"
  
  default from: "nick.desteffen@gmail.com"
  default to: "nick.desteffen@gmail.com"
    
  def new_contact_message(contact_message)
    @contact_message = contact_message
    mail(subject: contact_message.subject)
  end
  
end
