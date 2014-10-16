	post '/peeps' do
	  message = params["message"]
	  user = params["user"]
	  Peep.create(:message => message, :user => user)
	  redirect to('/')
	end