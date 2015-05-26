require 'spec_helper'

describe AppService do
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

  let(:heroku_app_setup_mock) { double("heroku_app_setup_mock") }
  let(:app_service) { AppService.new }
  let(:app_setup_id) {"id"}
  
  before(:each) do
    allow(heroku_app_setup_mock).to receive(:create).with(request_body).and_return({"id" => app_setup_id})
    allow(client_mock).to receive(:app_setup).and_return(heroku_app_setup_mock)
  end

  context "on create", :integration_test => true do
    
    context 'when heroku app setup creation is unsuccessful' do
      it 'returns a hash with status failed and error message' do
        heroku_response = double("heroku_response", data: {body: "{\"message\":\"You did something wrong!\"}"})
        allow(heroku_app_setup_mock).to receive(:create).and_raise(Excon::Errors::UnprocessableEntity.new("error", nil, heroku_response))
        expect(app_service.create(client_mock, request_body)).to eq({"status" => "failed", "message" => "You did something wrong!"})
      end
    end

    context "when heroku app setup creation is successful" do 
      it "should poll heroku until app status is resolved to succeeded" do 
        allow(heroku_app_setup_mock).to receive(:info).with(app_setup_id).and_return({"status" => "pending"}, 
          {"status" => "succeeded"})

        result = app_service.create(client_mock, request_body)
        expect(result).to eq({"status"=> "succeeded"})
      end

      context "when polling status results in a failed" do 
        xit "should return hash with status failed and error message" do 
          failed_message = {"id"=>"c3cd21ed-44b8-4cb9-8d56-c0781cee637c", 
            "failure_message"=>"invalid app.json", 
            "status"=>"failed", 
            "app"=>{"id"=>"3be4c77d-647a-46c5-bfe5-072e834feba0", "name"=>"newpagedashtag33"}, 
            "build"=>{"id"=>nil, "status"=>nil}, 
            "manifest_errors"=>["config var \"HASHTAGS\" is required", "config var \"CENSORED_WORDS\" is required", "config var \"CENSORED_USERS\" is required", "config var \"TWITTER_CONSUMER_KEY\" is required", "config var \"TWITTER_CONSUMER_SECRET\" is required", "config var \"INSTAGRAM_CLIENT_ID\" is required", "config var \"TWITTER_USERS\" is required", "config var \"INSTAGRAM_USERS\" is required", "config var \"INSTAGRAM_USER_IDS\" is required", "config var \"FONT_FAMILY\" is required", "config var \"HEADER_TITLE\" is required", "config var \"HEADER_LINK\" is required", "config var \"HEADER_COLOR\" is required", "config var \"BACKGROUND_COLOR\" is required", "config var \"POST_COLOR_1\" is required", "config var \"POST_COLOR_2\" is required", "config var \"POST_COLOR_3\" is required", "config var \"POST_COLOR_4\" is required", "config var \"API_RATE\" is required"], "postdeploy"=>{"output"=>nil, "exit_code"=>nil}, "resolved_success_url"=>nil, "created_at"=>"2015-05-22T21:45:08+00:00", "updated_at"=>"2015-05-22T21:45:09+00:00"}
          allow(heroku_app_setup_mock).to receive(:info).with(app_setup_id).and_return({"status" => "failed"})

          result = app_service.create(client_mock, request_body)
          expect(result).to eq({"status"=> "failed"})
        end 
      end
    end
  end
end