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
                "TWITTER_CONSUMER_SECRET" => app_options[:twitter_consumer_secret]
	            }
	        }
	    }
    	
    	begin
			client.app_setup.create(arguments) 
		rescue Exception => e
            return JSON.load(e.response.data[:body])["message"]
		end 
	end
end