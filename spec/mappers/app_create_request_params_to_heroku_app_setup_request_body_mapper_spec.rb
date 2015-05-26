require 'spec_helper'

describe AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper do 

  let(:mapper) {AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper.new()}
  it "should build a request body" do
    params = {name: "mydashtagpage", hashtags: "hash"} 


    request_body = { 
        "app"=> {
          "name" => "mydashtagpage"
        },
        "source_blob" => 
            { "url" => "https://github.com/anirudh-eka/dashtag_solo/tarball/master/"},
        "overrides" => {
            "env" => {
                "HASHTAGS" => "hash"
                }
          }
      }
    expect(mapper.build(params)).to eq(request_body)
  end

  context "when some environment variables are not set" do
    it "should not add them to the request body" do
      params = {"name"=>"hereisaname", "hashtags"=>"", "twitter_consumer_key"=>""}

      request_body = { 
        "app"=> {
          "name" => "hereisaname"
        },
        "source_blob" => 
            { "url" => "https://github.com/anirudh-eka/dashtag_solo/tarball/master/"},
        "overrides" => {
            "env" => {}
          }
      }
      expect(mapper.build(params)).to eq(request_body)
    end
  end
end