class DashtagPageController < ApplicationController
  before_action :load_app_setup_service, :load_mapper, :load_heroku_platform_api_service


  def new
  end
  def success
  end
  def create
    client = @heroku_platform_api_service.create_client(session[:access_token])
    request_body = @mapper.build(params[:dashtag_page])

    begin
      app_setup = @app_setup_service.create(client, request_body)
      redirect_to :action => "success"
    rescue AppSetupException => e
      flash[:error] = e.message 
      redirect_to :action => "new"
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

  def load_heroku_platform_api_service(service = HerokuPlatformAPIService.new)
    @heroku_platform_api_service ||= service
  end

  def load_mapper(mapper = AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper.new)
    @mapper = mapper
  end
end 