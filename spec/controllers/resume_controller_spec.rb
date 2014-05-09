require 'spec_helper'

describe ResumeController do

  describe "index" do
    it "send the resume file from Github" do
      allow(controller).to receive(:render)
      resume = double(:resume, body: "Nicholas DeSteffen Resume")
      allow(Net::HTTP).to receive(:get_response).and_return(resume)
      allow(controller).to receive(:send_data).once

      get :index

      expect(response).to be_success
    end
  end

end
