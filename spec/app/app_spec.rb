require File.expand_path '../../spec_helper.rb', __FILE__

describe "The Remote AppleScript server" do

  it "should allow accessing the home page" do
    get '/'
    last_response.body.should == "AppleScript server is up!"
    last_response.should be_ok
  end

  it "should throw an error when no script is provided" do
    post '/execute'
    last_response.should be_ok
    JSON.parse(last_response.body)["status"].should == "error"
    JSON.parse(last_response.body)["message"].should == "no script provided"
  end

  it "should throw an error when the script is malformed" do
  	body = {:script => "tell%20application%20%22iTunes%22%0D%09activate%0Dend%20tel"}
    post '/execute', body

    JSON.parse(last_response.body)["status"].should == "error"
    JSON.parse(last_response.body)["message"].should == "error executing script: 43:46: syntax error: Expected “tell”, etc. but found identifier. (-2741)"
    last_response.should be_ok
  end

  it "should return ok when the execution was successful" do
  	body = {:script => "tell%20application%20%22iTunes%22%0D%09activate%0Dend%20tell"}
    post '/execute', body

    last_response.should be_ok
    JSON.parse(last_response.body)["status"].should == "ok"
  end

end
