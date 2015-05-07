class DashtagController < ApplicationController
  def new
  end

  def create
    client = PlatformAPI.connect_oauth(session[:access_token])

    client.app_setup.create({ 
        "app"=> {
          "name" => "dashtagfromearth"
        },
        "source_blob" => 
            { "url" => "https://github.com/anirudh-eka/dashtag_solo/tarball/master/"},
        "overrides" => {
            "env" => {
                "HASHTAGS" => params[:hashtags],
                "TWITTER_CONSUMER_KEY" => params[:twitter_consumer_key],
                "TWITTER_CONSUMER_SECRET" => params[:twitter_consumer_secret]
            }
        }
    })
  	redirect_to :action => "new"
  end
end