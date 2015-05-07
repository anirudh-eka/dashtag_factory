class SessionController < ApplicationController
  def index
  end

  def new
    redirect_to "/auth/heroku"
  end

  def create
    access_token = request.env['omniauth.auth']['credentials']['token']
    # DO NOT store this token in an unencrypted cookie session
    # Please read "A note on security" below!
    client = PlatformAPI.connect_oauth(access_token)
    session[:access_token] = access_token
  #   begin
  #     client.app_setup.create({ 
  #     	"app"=> {
		# 	"name" => "dashtagfromearth"
		# },
  #     	"source_blob" => 
  #     		{ "url" => "https://github.com/anirudh-eka/dashtag_solo/tarball/master/"} 
  #     })
  #   rescue Exception => e
  #     puts "*" * 80
  #     puts e.class
  #     puts e.message
  #     puts "-" * 80
  #     puts e.request[:body]
  #     puts "+" * 80
  #     puts e.response.data
  #   end
    # heroku_api = Heroku::API.new(api_key: access_token)
    @apps = client.app.list
  end
end
