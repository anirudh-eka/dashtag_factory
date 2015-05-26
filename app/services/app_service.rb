class AppService
	def initialize(app_setup_service=AppSetupService.new)
		@app_setup_service = app_setup_service
	end
	
	def create(client, request_body)
        begin
    		  app_setup = @app_setup_service.create(client, request_body)
        rescue AppSetupException => e
          return {"status" => "failed", "message" => e.message}
        end
        app_setup_status_info = app_setup.poll_until_app_status_resolved
        
        return {"status" => "succeeded" } if app_setup_status_info["status"] == "succeeded"
        {"status" => "failed", "message" => "Heroku deploy failed."} if app_setup_status_info["status"] == "failed"
	end
end