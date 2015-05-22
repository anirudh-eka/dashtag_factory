class DashtagPageController < ApplicationController
  before_action :load_app_service, :load_mapper, :load_heroku_platform_api_service


  def new
  end
  def success
  end
  def create
    client = @heroku_platform_api_service.create_client(session[:access_token])
    request_body = @mapper.build(params[:dashtag_page])

    app_create_result = @app_service.create(client, request_body)
    if app_create_result["status"] == "failed"
      flash[:error] = app_create_result["message"]
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

  def load_app_service(service = AppService.new)
    @app_service ||= service
  end

  def load_heroku_platform_api_service(service = HerokuPlatformAPIService.new)
    @heroku_platform_api_service ||= service
  end

  def load_mapper(mapper = AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper.new)
    @mapper = mapper
  end
end 