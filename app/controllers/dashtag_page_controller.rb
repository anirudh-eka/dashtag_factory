class DashtagPageController < ApplicationController
  before_action :load_app_setup_service, :load_mapper


  def new
  end
  def success
  end
  def create
    # client = PlatformAPI.connect_oauth()
    # submit_form(client)
    # app_setup = AppSetup.new(client)
    app_setup = @app_setup_service.create(session[:access_token])

    # mapper = AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper.new
    request_body = @mapper.build(params[:dashtag_page])
    error_message = HerokuAppService.create_app_setup(app_setup, request_body)
    
    if error_message
      flash[:error] = error_message 
      redirect_to :action => "new"
    else
      redirect_to :action => "success"
    end
  end
  
  def twitter_api_screenshots
  end

  def instagram_api_screenshots
  end

  def index
  end

  def load_app_setup_service(service = AppSetupService.new)
    @app_setup_service ||= service
  end

  def load_mapper(mapper = AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper.new)
    @mapper = mapper
  end
end 


class AppSetupService
  def create(platform_api_access_token)
    AppSetup.new(PlatformAPI.connect_oauth(platform_api_access_token))
  end
end