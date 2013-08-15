require 'spec_helper'

describe ResumeController do

  describe "index" do
    it "send the resume file from Github" do
      controller.stub(:render)
      resume = double(:resume, body: "Nicholas DeSteffen Resume")
      Net::HTTP.stub(:get_response).and_return(resume)
      controller.should_receive(:send_data).once

      get :index

      response.should be_success
    end
  end

end
