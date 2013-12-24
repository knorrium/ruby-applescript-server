ruby-applescript-server
=======================

Execute AppleScript remotely over HTTP

usage
-----

Install the dependencies

```
bundle install
```

Run the server

```
ruby server.rb
```

Send a POST request with the `script` parameter and the actual script you want to execute

```
curl -X POST --data "script=tell%20application%20%22iTunes%22%0D%09activate%0Dend%20tell" http://localhost:9494/execute
```

If the execution was OK, you should get the following response:

```
{"status":"ok"}
```

Otherwise (usually when there is a syntax error), you should receive an error message:

```
{"status":"error executing script: 43:46: syntax error: Expected “tell”, etc. but found identifier. (-2741)"}
```
