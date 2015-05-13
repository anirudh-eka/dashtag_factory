class HerokuAppService
	def self.create_app(client, app_options)	
		arguments = { 
        "app"=> {
          # "name" => "dashtagfrommars"
          "name" => app_options[:name]
        },
        "source_blob" => 
            { "url" => "https://github.com/anirudh-eka/dashtag_solo/tarball/master/"},
        "overrides" => {
            "env" => {
                "HASHTAGS" => app_options[:hashtags],
                "TWITTER_CONSUMER_KEY" => app_options[:twitter_consumer_key],
                "TWITTER_CONSUMER_SECRET" => app_options[:twitter_consumer_secret],
                
                "CENSORED_WORDS" => app_options[:censored_words],
                "CENSORED_USERS" => app_options[:censored_users],
                "INSTAGRAM_CLIENT_ID" => app_options[:instagram_client_id],
                "TWITTER_USERS" => app_options[:twitter_users],
                "INSTAGRAM_USERS" => app_options[:instagram_users],
                "INSTAGRAM_USER_IDS" => app_options[:instagram_user_ids],
                "FONT_FAMILY" => app_options[:font_family],
                "HEADER_TITLE" => app_options[:header_title],
                "HEADER_LINK" => app_options[:header_link],
                "HEADER_COLOR" => app_options[:header_color],
                "BACKGROUND_COLOR" => app_options[:background_color],
                "POST_COLOR_1" => app_options[:post_color_1],
                "POST_COLOR_2" => app_options[:post_color_2],
                "POST_COLOR_3" => app_options[:post_color_3],
                "POST_COLOR_4" => app_options[:post_color_4],
                "API_RATE" => app_options[:api_rate]
                }
	        }
	    }
    	
    	begin
            client.app_setup.create(arguments) 
            return true
		rescue Exception => e
            return JSON.load(e.response.data[:body])["message"]
		end 
	end
end