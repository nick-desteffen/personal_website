class Notifier < ActionMailer::Base
  
  default from: "nick.desteffen@gmail.com"
  default to: "nick.desteffen@gmail.com"
  
  def resume_download(whois, ip)
    @whois = whois
    @ip = ip
    mail(:subject => "Resume downloaded!")
  end
  
end
