require 'spec_helper'

describe DashtagPageController do
	context 'When creating a heroku app' do 
		it 'calls the HerokuAppService with the correct request_body and a new app_setup' do 
			app_setup = AppSetup.new("blah", "something")
			app_setup_service_mock = double();
			allow(app_setup_service_mock).to receive(:create).with(any_args).and_return(app_setup)

			app_setup_service = controller.
        		load_app_setup_service(app_setup_service_mock)

			request_body = { 
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
		      }

			expect(HerokuAppService).to receive(:create_app_setup).with(app_setup, request_body).and_return(false)

			post :create, dashtag_page: {name: "something", hashtags: "hash"}
		end
	end
end