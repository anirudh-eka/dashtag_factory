class AppSetupService
  def create(client, request_body)
  	AppSetup.new(create_app_setup_on_heroku(client, request_body)["id"], client)
  end
end

private
def create_app_setup_on_heroku(client, request_body)
	begin
	  client.app_setup.create(request_body)
	rescue Excon::Errors::UnprocessableEntity => e
	  message = JSON.load(e.response.data[:body])["message"]
	  raise AppSetupException.new, message
	end
end