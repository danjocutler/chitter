require 'bcrypt'

class User

	include DataMapper::Resource

	has n, :peeps

	attr_reader :password
	attr_accessor :password_confirmation

	property :id, Serial
	property :name, String
	property :username, String, unique: true, message: "This username is already taken"
	property :email, String, unique: true, message: "This email is already taken"
	property :password_digest, Text

	validates_confirmation_of :password, message: "Sorry, your passwords don't match"

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(email: email)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end
end