class AppSetupService
  def create(platform_api_access_token)
    AppSetup.new(PlatformAPI.connect_oauth(platform_api_access_token))
  end
end