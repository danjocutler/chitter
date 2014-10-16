require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require './lib/peep'
require './lib/user'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

	get '/' do
		@peeps = Peep.all
		erb :index
	end

	post '/peeps' do
	  message = params["message"]
	  user = params["user"]
	  Peep.create(:message => message, :user => user)
	  redirect to('/')
	end

	get '/users/new' do
		@user = User.new
		erb :"users/new"
	end

	post '/users' do
   @user = User.new(:name => params[:name],
						:username => params[:username],
		    		:email => params[:email],
				    :password => params[:password],
				    :password_confirmation => params[:password_confirmation])
		if @user.save
			session[:user_id] = @user.id
			redirect to('/')
		else
			flash.now[:errors] = @user.errors.full_messages
			erb :"users/new"
		end
	end

	get '/sessions/new' do
	  erb :"sessions/new"
	end

	post '/sessions' do
	  email, password = params[:email], params[:password]
	  user = User.authenticate(email, password)
	  if user
	    session[:user_id] = user.id
	    redirect to '/'
	  else
	    flash[:errors] = ["The email or password is incorrect"]
	    erb :"sessions/new"
	  end
	end
