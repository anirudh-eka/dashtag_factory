class DashtagPageController < ApplicationController
  def new
  end
  def create
    client = PlatformAPI.connect_oauth(session[:access_token])
    # submit_form(client)
    HerokuAppService.create_app(client, params)    

  	redirect_to :action => "new"
  end
  
  def twitter_api_screenshots
  end

  def index
  end

end 
