class AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper

	def build(create_request_params)
    	request_body = { 
	      "app"=> {
	        "name" => create_request_params[:name]
	      },
	      "source_blob" => 
	          { "url" => "https://github.com/anirudh-eka/dashtag_solo/tarball/master/"},
	      "overrides" => {
	          "env" => {}
        	} 
      }

      add_environment_variables(create_request_params, request_body)
	end

  private
  def add_environment_variables(params, request_body)
    params.select {|key, value| key.to_s != :name.to_s }.each { |env_var_name, env_var_value|
      add_environment_variable(request_body, env_var_name, env_var_value)
    }
    request_body
  end

  def add_environment_variable(request_body, env_var_name, env_var_value)
    request_body["overrides"]["env"][env_var_name.to_s.upcase] = env_var_value
  end
end