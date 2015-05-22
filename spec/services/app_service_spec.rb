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
  	it "should poll heroku until app status is resolved to succeeded" do 
      allow(heroku_app_setup_mock).to receive(:info).with(app_setup_id).and_return({"status" => "pending"}, 
        {"status" => "succeeded"})

      result = app_service.create(client_mock, request_body)
      expect(result).to eq({"status"=> "succeeded"})
    end

    context "when polling status results in a failed" do 
      it "should return hash with status failed and error message" do 
        allow(heroku_app_setup_mock).to receive(:info).with(app_setup_id).and_return({"status" => "failed"})

        result = app_service.create(client_mock, request_body)
        expect(result).to eq({"status"=> "failed"})
      end 
    end

    context 'when app setup creation is unsuccessful' do
      it 'returns a hash with status failed and error message' do
        heroku_response = double("heroku_response", data: {body: "{\"message\":\"You did something wrong!\"}"})
        allow(heroku_app_setup_mock).to receive(:create).and_raise(Excon::Errors::UnprocessableEntity.new("error", nil, heroku_response))
        expect(app_service.create(client_mock, request_body)).to eq({"status" => "failed", "message" => "You did something wrong!"})
      end
    end
  end
end