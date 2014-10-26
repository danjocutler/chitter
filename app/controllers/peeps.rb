	post '/peeps' do
	  message = params["message"]
	  username = session[:username]
	  Peep.create(message: message, username: username)
	  redirect to('/')
	end