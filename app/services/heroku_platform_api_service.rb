class HerokuPlatformAPIService
	def create_client(access_token)
		client = PlatformAPI.connect_oauth(access_token)
	end
end