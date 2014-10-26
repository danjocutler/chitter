	get '/sessions/new' do
	  erb :"sessions/new"
	end

	post '/sessions' do
	  email, password, username = params[:email], params[:password], params[:username]
	  user = User.authenticate(email, password)
	  if user
	    session[:user_id] = user.id
	    redirect to '/'
	  else
	    flash[:errors] = ["The email or password is incorrect"]
	    erb :"sessions/new"
	  end
	end

	delete '/sessions' do
    flash[:notice] = "Goodbye!"
    session[:user_id] = nil
    redirect '/'
  end 