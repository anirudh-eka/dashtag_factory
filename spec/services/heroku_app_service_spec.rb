require 'spec_helper'

describe HerokuAppService do
	context 'When creating an app' do 
	    context "When creation succeeds" do
	      it "should create app setup" do
	        app_setup_mock = double("app_setup")
	        request_body = double("request_body")
	        expect(app_setup_mock).to receive(:create).with(request_body).and_return(true)
	        
	        HerokuAppService.create_app_setup(app_setup_mock, request_body)
	      end  

	      it "should return nil" do
	        app_setup_mock = double("app_setup")
	        request_body = double("request_body")
	        allow(app_setup_mock).to receive(:create).with(request_body).and_return(true)
	        
	        expect(HerokuAppService.create_app_setup(app_setup_mock, request_body)).to eq(nil) 
	      end     
	    end

	    context 'When initial app_setup creation fails' do
	      it "should return error message" do
	        app_setup_mock = double("app_setup")
	        allow(app_setup_mock).to receive(:create).and_raise(AppSetupException.new, "status error")

	        expect(HerokuAppService.create_app_setup(app_setup_mock, {})).to eq("status error")
	      end
	    end

	    context "When app_setup status fails"
	end
end