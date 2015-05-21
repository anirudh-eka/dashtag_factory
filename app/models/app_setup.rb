class AppSetup
  attr_reader :status, :id

	def initialize(id, client)
  	@client = client
    @id = id
	end

  def update_status 
    @client.app_setup.info(@id)["status"]
  end

end

# AppSetupService
  # - .create #=> AppSetup || throws an error
# AppSetup 
  # when initialized needs client and an id
  # - update_status/polling, etc.
