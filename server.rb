require "sinatra"
require "json"
require "open3"

set :server, 'webrick'
set :bind, '0.0.0.0'
set :port, 9494

get "/" do
	return "AppleScript server is up!"
end

post "/execute" do
	if params["script"] then
		script = params["script"]

		result = Open3.capture3("osascript<<APPLESCRIPT
			#{URI.decode(script)}
		APPLESCRIPT")

		if result[0].to_s.strip == "AppleScript"
			response = {:status => "ok"}.to_json
		else
			response = {:status => "error executing script: #{result[1].to_s.strip}"}.to_json
		end
	else
		response = {:status => "no script provided"}.to_json
	end

	content_type :json
	return response
end
