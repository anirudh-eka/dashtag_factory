require 'spec_helper'

describe DashtagPageController do
	context 'When creating a heroku app' do 
		it 'calls the heroku_app_service' do 
			dashtag_page_controller = DashtagPageController.new
			# stub client
			client_mock = double()
			allow(PlatformAPI).to receive(:connect_oauth).and_return(client_mock)
			# stub params
			params = {"name" =>"something", "controller" => "dashtag_page", "action" => "create"}
			expect(HerokuAppService).to receive(:create_app).with(client_mock, params)

			post :create, name: "something"
		end
	end
end