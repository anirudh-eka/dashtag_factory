class AppSetup
  attr_reader :status

	def initialize(client)
  	@client = client
    # response = create_app_setup_on_heroku(request_body)
  	# @id = response["id"]
	end

  def create(request_body)
    @id = create_app_setup_on_heroku(request_body)["id"]
  end

  def update_status
    raise AppSetupException.new, "Did not create AppSetup. Try calling create on this instance." unless @id
    @client.app_setup.info(@id)["status"]
  end

  private

  def create_app_setup_on_heroku(request_body)
    begin
      @client.app_setup.create(request_body)
    rescue Excon::Errors::UnprocessableEntity => e
      message = JSON.load(e.response.data[:body])["message"]
      raise AppSetupException.new, message
    end
  end
end