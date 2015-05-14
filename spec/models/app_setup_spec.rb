require 'spec_helper'

describe AppSetup do
  let(:client_mock) { double("client")}

  let(:app_setup) { AppSetup.new(client_mock,
      {"id"=>"fd8db1bb-d568-43e4-9bdc-e07fed76f05b", 
      "failure_message"=>nil, 
      "status"=>"pending", 
      "app"=>{"id"=>"8c9b4cc6-5663-4223-9348-7ef9d2c6edac", 
        "name"=>"successdashtag"}, 
      "build"=>{"id"=>nil, "status"=>nil}, 
      "manifest_errors"=>[], 
      "postdeploy"=>{"output"=>nil, "exit_code"=>nil}, 
      "resolved_success_url"=>nil, 
      "created_at"=>"2015-05-14T18:41:49+00:00", 
      "updated_at"=>"2015-05-14T18:41:49+00:00"}) }

	it "has status" do
		expect(app_setup.status).to eq("pending")
	end


	context "when updated" do
		it "gets new status" do

      result = 
        {"id"=>"fd8db1bb-d568-43e4-9bdc-e07fed76f05b", 
          "failure_message"=>nil, 
          "status"=>"success", 
          "app"=>{"id"=>"50cbe102-8a89-4978-a384-35dd3fef7d07", 
            "name"=>"helloappdashtag"}, 
          "build"=>{"id"=>nil, "status"=>nil}, 
          "manifest_errors"=>[], 
          "postdeploy"=>{"output"=>nil, "exit_code"=>nil}, 
          "resolved_success_url"=>nil, 
          "created_at"=>"2015-05-14T19:28:03+00:00", 
          "updated_at"=>"2015-05-14T19:28:03+00:00"}

      app_setup_mock = double("app setup mock")

      allow(app_setup_mock).to receive(:info).with("fd8db1bb-d568-43e4-9bdc-e07fed76f05b").and_return(result)
      allow(client_mock).to receive(:app_setup).and_return(app_setup_mock)

      expect(app_setup.update_status).to eq("success")
		end
	end
end