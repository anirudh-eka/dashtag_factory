require 'spec_helper'

describe DashtagPageController do
	context 'When creating a heroku app' do 
		it 'calls the heroku_app_service' do 
			dashtag_page_controller = DashtagPageController.new
			client_mock = double()
			app_mock = {"status" => "pending"}

			allow(PlatformAPI).to receive(:connect_oauth).and_return(client_mock)
			params = {"name" =>"something", "controller" => "dashtag_page", "action" => "create"}
			expect(HerokuAppService).to receive(:create_app_setup).with(client_mock, params).and_return(app_mock)

			post :create, name: "something"
		end
	end
end