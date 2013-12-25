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

		message = result[0].to_s.strip
		unless message.empty? || message.nil?
			response = {:status => "ok", :message => message}.to_json
		else
			response = {:status => "error", :message => "error executing script: #{result[1].to_s.strip}"}.to_json
		end
	else
		response = {:status => "error", :message => "no script provided"}.to_json
	end

	content_type :json
	return response
end
