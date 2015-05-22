require 'spec_helper'

describe DashtagPageController do
	let(:request_body) {{ 
		        "app"=> {
		          "name" => "something"
		        },
		        "source_blob" => 
		            { "url" => "https://github.com/anirudh-eka/dashtag_solo/tarball/master/"},
		        "overrides" => {
		            "env" => {
		                "HASHTAGS" => "hash"
		                }
		          }
		      }}
	let(:client_mock) {double}
	let(:app_service_mock) {double}
	let(:heroku_platform_api_service_mock) {double}
	
	before(:each) do 
		allow(heroku_platform_api_service_mock).to receive(:create_client).with(any_args).and_return(client_mock)
		controller.load_app_service(app_service_mock)
		controller.load_heroku_platform_api_service(heroku_platform_api_service_mock)
	end

	context 'When creating a heroku app' do 
		it 'creates an app_setup and redirects to success page' do 
			allow(app_service_mock).to receive(:create).with(client_mock, request_body).and_return({"status"=>"succeeded"})
			post :create, dashtag_page: {name: "something", hashtags: "hash"}
			expect(response).to redirect_to(success_path) 
		end

		context 'When app_setup creation is unsuccessful' do
			it 'redirects to the launch page with error flash message' do
				allow(app_service_mock).to receive(:create).with(client_mock, request_body).and_return({"status"=>"failed", "message" => "Heroku app setup failed"})
				post :create, dashtag_page: {name: "something", hashtags: "hash"}
				expect(response).to redirect_to(launch_page_path)
				expect(flash[:error]).to eq("Heroku app setup failed")
			end
		end
	end
end