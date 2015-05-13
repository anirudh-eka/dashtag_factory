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

		it 'sets the env variables correctly' do 
			app_setup_mock = AppSetupMock.new
			client_mock = double("client", app_setup: app_setup_mock)
			
			app_options = {hashtags: "hash", 
							twitter_consumer_key: "key", 
							twitter_consumer_secret: "secret",
							censored_words: "bad",
							censored_users: "bad user",
							instagram_client_id: "insta client id",
							twitter_users: "monkeygirltwitta",
							instagram_users: "monkeygirlinsta",
							instagram_user_ids: "insta id",
							font_family: "comic sans",
							header_title: "Cute Monkeys",
							header_link: "linktomonkeys",
							header_color: "purple",
							background_color: "blue",
							post_color_1: "orange",
							post_color_2: "red",
							post_color_3: "maroon",
							post_color_4: "violet"}			

			HerokuAppService.create_app(client_mock, app_options)
			expect(app_setup_mock.create_args["overrides"]["env"]["HASHTAGS"]).to eq(app_options[:hashtags])
			expect(app_setup_mock.create_args["overrides"]["env"]["TWITTER_CONSUMER_KEY"]).to eq(app_options[:twitter_consumer_key])
			expect(app_setup_mock.create_args["overrides"]["env"]["TWITTER_CONSUMER_SECRET"]).to eq(app_options[:twitter_consumer_secret])
			expect(app_setup_mock.create_args["overrides"]["env"]["CENSORED_WORDS"]).to eq(app_options[:censored_words])
			expect(app_setup_mock.create_args["overrides"]["env"]["CENSORED_USERS"]).to eq(app_options[:censored_users])
			expect(app_setup_mock.create_args["overrides"]["env"]["INSTAGRAM_CLIENT_ID"]).to eq(app_options[:instagram_client_id])
			expect(app_setup_mock.create_args["overrides"]["env"]["TWITTER_USERS"]).to eq(app_options[:twitter_users])
			expect(app_setup_mock.create_args["overrides"]["env"]["INSTAGRAM_USERS"]).to eq(app_options[:instagram_users])
			expect(app_setup_mock.create_args["overrides"]["env"]["INSTAGRAM_USER_IDS"]).to eq(app_options[:instagram_user_ids])
			expect(app_setup_mock.create_args["overrides"]["env"]["FONT_FAMILY"]).to eq(app_options[:font_family])
			expect(app_setup_mock.create_args["overrides"]["env"]["HEADER_TITLE"]).to eq(app_options[:header_title])
			expect(app_setup_mock.create_args["overrides"]["env"]["HEADER_LINK"]).to eq(app_options[:header_link])
			expect(app_setup_mock.create_args["overrides"]["env"]["HEADER_COLOR"]).to eq(app_options[:header_color])
			expect(app_setup_mock.create_args["overrides"]["env"]["BACKGROUND_COLOR"]).to eq(app_options[:background_color])
			expect(app_setup_mock.create_args["overrides"]["env"]["POST_COLOR_1"]).to eq(app_options[:post_color_1])
			expect(app_setup_mock.create_args["overrides"]["env"]["POST_COLOR_2"]).to eq(app_options[:post_color_2])
			expect(app_setup_mock.create_args["overrides"]["env"]["POST_COLOR_3"]).to eq(app_options[:post_color_3])
			expect(app_setup_mock.create_args["overrides"]["env"]["POST_COLOR_4"]).to eq(app_options[:post_color_4])
		end

		context "When creation fails" do
			it "should return error message" do
				app_setup_mock = double("app_setup")
				mock_response = double("response")
				status_error = Excon::Errors::UnprocessableEntity.new("The status is bad", nil, mock_response)
				client_mock = double("client", app_setup: app_setup_mock)

				allow(app_setup_mock).to receive(:create).and_raise(status_error)
				allow(mock_response).to receive(:data).and_return({body:"{\"message\":\"Name must start with a letter\"}"})

				expect(HerokuAppService.create_app(client_mock, {})) .to eq("Name must start with a letter")	

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