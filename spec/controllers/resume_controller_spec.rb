require 'spec_helper'

describe ResumeController do
  
  describe "index" do
    it "send the resume file and sends an email" do
      controller.stubs(:render)
      controller.expects(:send_file).with("#{Rails.root}/public/nicholas_desteffen_resume.pdf", :type => "application/pdf").once

      get :index
      
      response.should be_success
    end
  end
  
end
