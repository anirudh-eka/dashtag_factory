require 'spec_helper'

describe AppSetupService do
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

  let(:app_setup_mock) { double("app_setup_mock") }
  let(:app_setup_service) { AppSetupService.new }
  
  before(:each) do
    allow(app_setup_mock).to receive(:create).with(request_body).and_return({"id" => "id"})
    allow(client_mock).to receive(:app_setup).and_return(app_setup_mock)
  end

  context "on create" do
  	it "should return a new AppSetup" do  
      app_setup = app_setup_service.create(client_mock, request_body)
      expect(app_setup.id).to eq("id")
    end

    context 'when unsuccessful' do
      it 'throws an AppSetupException with message' do
        heroku_response = double("heroku_response", data: {body: "{\"message\":\"You did something wrong!\"}"})
        allow(app_setup_mock).to receive(:create).and_raise(Excon::Errors::UnprocessableEntity.new("error", nil, heroku_response))
        expect{app_setup_service.create(client_mock, request_body)}.to raise_error(AppSetupException, "You did something wrong!")
      end
    end
  end
end