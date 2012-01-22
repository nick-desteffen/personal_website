class ResumeController < ApplicationController
  
  def index
    send_file("#{Rails.root}/public/nicholas_desteffen_resume.pdf", :type => "application/pdf")
  end
  
end
