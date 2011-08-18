class ResumeController < ApplicationController
  
  def index
    ip_address = request.env['REMOTE_ADDR']
    whois = Whois.query(ip_address).to_s.split("\n")
    
    ## TODO Email me
    Rails.logger.info(whois)
    #Mailer.deliver... (Time.now, whois, ip)
    
    send_file("#{Rails.root}/public/nicholas_desteffen_resume.pdf", :type => "application/pdf")
  end
  
end
