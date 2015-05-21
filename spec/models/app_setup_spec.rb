require 'spec_helper'

describe AppSetup do
	context "on update" do
    let(:app_setup_id) {"fd8db1bb-d568-43e4-9bdc-e07fed76f05b" }
    let(:heroku_app_setup_mock) { double("heroku app setup mock")}

		it "gets new status" do
      app_setup_info = 
        {"id"=> app_setup_id,
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

      client_mock = double("client")

      allow(client_mock).to receive(:app_setup).and_return(heroku_app_setup_mock)
      allow(heroku_app_setup_mock).to receive(:info).with(app_setup_id).and_return(app_setup_info)

      app_setup = AppSetup.new(app_setup_id, client_mock) 

      expect(app_setup.update_status).to eq("success")
		end
	end
end