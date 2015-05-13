class DashtagPageController < ApplicationController
  def new
  end
  def success
  end
  def create
    client = PlatformAPI.connect_oauth(session[:access_token])
    # submit_form(client)
    result = HerokuAppService.create_app(client, params)
    if result == true
      redirect_to :action => "success"
    else
      flash[:error] = result    
  	  redirect_to :action => "new"
    end
  end
  
  def twitter_api_screenshots
  end

  def instagram_api_screenshots
  end

  def index
  end

end 
