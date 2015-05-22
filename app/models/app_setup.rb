class AppSetup
  attr_reader :status, :id

	def initialize(id, client)
  	@client = client
    @id = id
	end

  def poll_until_app_status_resolved 
    latest_info = nil
    while true
      latest_info = @client.app_setup.info(@id)
      if latest_info["status"] == "succeeded" ||latest_info["status"] == "failed"
        return latest_info
      end
      sleep(1)
    end
  end
end