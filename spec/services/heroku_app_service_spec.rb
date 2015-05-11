require 'spec_helper'

describe HerokuAppService do
	context 'When creating an app' do 
		it 'sets the name correctly' do 
			app_setup_mock = AppSetupMock.new
			client_mock = double("client", app_setup: app_setup_mock)
			
			app_options = {name: "hereisaname"}			

			HerokuAppService.create_app(client_mock, app_options)
			expect(app_setup_mock.create_args["app"]["name"]).to eq(app_options[:name])
		end

		context "When app_setup creation fails" do
			it "should return error message" do
				app_setup_mock = double("app_setup")
				status_error = Excon::Errors::HTTPStatusError.new("The status is bad")
				allow(app_setup_mock).to receive(:create).and_raise(status_error)

				client_mock = double("client", app_setup: app_setup_mock)

				expect(HerokuAppService.create_app(client_mock, {})) .to eq(status_error.message)	

			end			
		end
	end
end


class AppSetupMock
	attr_reader :create_args

	def create (args)
		@create_args = args
	end
end