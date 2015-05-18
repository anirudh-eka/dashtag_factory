require 'spec_helper'

describe AppSetup do
  let(:client_mock) { double("client")}
  let(:request_body) {{ 
      "app"=> {
        "name" => "dashtagpage"
      },
      "source_blob" => 
          { "url" => "https://github.com/anirudh-eka/dashtag_solo/tarball/master/"},
      "overrides" => {
          "env" => {
              "HASHTAGS" => "stuff"
              }
        }}}

  context "when created" do
  	it "sends request to heroku api to create app_setup" do
      heroku_app_setup_mock = double("heroku app setup mock")
      allow(client_mock).to receive(:app_setup).and_return(heroku_app_setup_mock)

      expect(heroku_app_setup_mock).to receive(:create).with(request_body).and_return({"id"=>"app_setup_id"})
      app_setup = AppSetup.new(client_mock)

      app_setup.create(request_body)
  	end

    it "should return error message" do
      mock_data = {body: "{\"message\":\"name is too short\"}"}
      mock_response = double("response", data: mock_data)
      heroku_app_setup_mock = double("heroku_app_setup")
      allow(heroku_app_setup_mock).to receive(:create).and_raise(Excon::Errors::UnprocessableEntity.new("status error", nil, mock_response))
      client_mock = double("client", app_setup: heroku_app_setup_mock)  
      app_setup = AppSetup.new(client_mock)

      expect{app_setup.create(request_body)}.to raise_error(AppSetupException, "name is too short")
    end
  end

	context "when updated after create" do
    let(:app_setup_id) {"fd8db1bb-d568-43e4-9bdc-e07fed76f05b" }
    let(:heroku_app_setup_mock) { double("heroku app setup mock")}
    before(:each) do 

      allow(heroku_app_setup_mock).to receive(:create).with(request_body).and_return({"id"=>app_setup_id})
    end

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

      
      allow(client_mock).to receive(:app_setup).and_return(heroku_app_setup_mock)
      allow(heroku_app_setup_mock).to receive(:info).with(app_setup_id).and_return(app_setup_info)

      app_setup = AppSetup.new(client_mock) 
      app_setup.create(request_body)

      expect(app_setup.update_status).to eq("success")
		end
	end

  context "when updating without creating" do
    it "should throw an exception" do
      heroku_app_setup_mock = double("heroku_app_setup_mock")
      allow(heroku_app_setup_mock).to receive(:info).with("e07fed76f05b")
      allow(client_mock).to receive(:app_setup).and_return(heroku_app_setup_mock)
      app_setup = AppSetup.new(client_mock) 
      expect{app_setup.update_status}.to raise_error(AppSetupException, "Did not create AppSetup. Try calling create on this instance.")
    end
  end
end