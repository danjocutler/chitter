	post '/peeps' do
	  message = params["message"]
	  Peep.create(message: message, user_id: current_user.id)
	  redirect to('/')
	end