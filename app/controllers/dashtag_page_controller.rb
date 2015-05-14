class DashtagPageController < ApplicationController
  def new
  end
  def success
  end
  def create
    client = PlatformAPI.connect_oauth(session[:access_token])
    # submit_form(client)
    error_message = HerokuAppService.create_app_setup(client, params)
    
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

end 
