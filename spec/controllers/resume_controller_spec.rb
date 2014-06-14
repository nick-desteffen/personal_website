require 'rails_helper'

describe ResumeController do

  describe "index" do
    it "send the resume file from Github" do
      allow(controller).to receive(:render)
      allow(controller).to receive(:send_data).once

      resume = double(:resume, body: "Nicholas DeSteffen Resume")
      http = double(:http, :request => resume, "use_ssl=" => true)
      allow(Net::HTTP).to receive(:new).and_return(http)
      allow(http).to receive(:request).and_return(resume)

      get :index

      expect(response).to be_success
    end
  end

end
