class HerokuAppService
	def self.create_app_setup(app_setup, request_body)	
  	   begin
         app_setup.create(request_body)
         nil
		rescue AppSetupException => e
         e.message
		end 
	end
end