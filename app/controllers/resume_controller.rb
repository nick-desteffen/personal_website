class ResumeController < ApplicationController

  def index
    uri = URI('https://raw.github.com/nick-desteffen/resume/master/Nicholas%20DeSteffen%20Resume.pdf')
    resume_response = Net::HTTP.get_response(uri)

    send_data(resume_response.body, type: "application/pdf", filename: "nicholas_desteffen_resume.pdf")
  end

end
