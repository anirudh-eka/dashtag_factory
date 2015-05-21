require 'spec_helper'

describe HerokuPlatformAPIService do
	it "creates client" do
		client_mock = double("client")
		access_token = "someaccessplease"
		allow(PlatformAPI).to receive(:connect_oauth).with(access_token).and_return(client_mock)
		
		heroku_platform_API_service = HerokuPlatformAPIService.new

		expect(heroku_platform_API_service.create_client(access_token)).to eq(client_mock)
	end
end