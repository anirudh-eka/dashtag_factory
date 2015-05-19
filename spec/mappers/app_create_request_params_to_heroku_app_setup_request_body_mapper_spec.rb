require 'spec_helper'

describe AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper do 
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


    mapper = AppCreateRequestParamsToHerokuAppSetupRequestBodyMapper.new();
    expect(mapper.build(params)).to eq(request_body)
  end
end