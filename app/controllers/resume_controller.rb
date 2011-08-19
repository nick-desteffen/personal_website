class ResumeController < ApplicationController
  
  def index
    ip_address = request.env['REMOTE_ADDR']
    whois = Whois.query(ip_address).to_s.split("\n")
    
    Notifier.resume_download(whois, ip_address).deliver
    
    send_file("#{Rails.root}/public/nicholas_desteffen_resume.pdf", :type => "application/pdf")
  end
  
end
