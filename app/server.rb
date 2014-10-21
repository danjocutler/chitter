require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require './app/models/peep'
require './app/models/user'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'
require_relative 'helpers/session'
require_relative 'controllers/application'
require_relative 'controllers/peeps'
require_relative 'controllers/sessions'
require_relative 'controllers/users'

include SessionHelpers

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
set :partial_template_engine, :erb
set :public_folder, 'public'







