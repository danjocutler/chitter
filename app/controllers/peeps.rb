	post '/peeps' do
	  message = params["message"]
	  username = session[:username]
	  Peep.create(message: message, user_id: current_user.id)
	  redirect to('/')
	end