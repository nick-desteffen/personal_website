class Notifier < ActionMailer::Base
  
  layout "application_mailer"
  
  default from: "nick.desteffen@gmail.com"
  default to: "nick.desteffen@gmail.com"
  
  def resume_download(whois, ip)
    @whois = whois
    @ip = ip
    mail(subject: "Resume download")
  end
  
  def new_contact_message(contact_message)
    @contact_message = contact_message
    mail(subject: contact_message.subject)
  end
  
end
