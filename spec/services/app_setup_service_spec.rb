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

  context "on create" do
  	it "should return a new AppSetup" do
      app_setup_mock = double("app_setup_mock")

      allow(app_setup_mock).to receive(:create).with(request_body).and_return({"id" => "id"})
      allow(client_mock).to receive(:app_setup).and_return(app_setup_mock)
      app_setup_service = AppSetupService.new

      app_setup = app_setup_service.create(client_mock, request_body)
      expect(app_setup.id).to eq("id")
    end
  end
end