class AppSetup
  attr_reader :status

	def initialize(client, args)
    @status = args["status"]
    @id = args["id"]
    @client = client
  end

  def update_status
    @status = @client.app_setup.info(@id)["status"]
  end
end