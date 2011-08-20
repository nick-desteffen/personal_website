require 'spec_helper'

describe ResumeController do
  render_views
  
  describe "index" do
    it "send the resume file and sends an email" do
      ActionMailer::Base.deliveries.clear
      Whois.stubs(:query).returns("")
      controller.stubs(:render)
      controller.expects(:send_file).with("#{Rails.root}/public/nicholas_desteffen_resume.pdf", :type => "application/pdf").once

      get :index
      
      ActionMailer::Base.deliveries.size.should == 1
    end
  end
  
end
