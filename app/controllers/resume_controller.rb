class ResumeController < ApplicationController

  def index
    uri = URI('https://raw.githubusercontent.com/nick-desteffen/resume/master/Nicholas%20DeSteffen%20Resume.pdf')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    resume_request = Net::HTTP::Get.new(uri.request_uri)
    resume_response = http.request(resume_request)

    send_data(resume_response.body, type: "application/pdf", filename: "nicholas_desteffen_resume.pdf")
  end

end
