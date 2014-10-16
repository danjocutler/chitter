require 'spec_helper'

feature "User signs up" do

	scenario "when being logged out" do
		expect {sign_up}.to change(User, :count).by 1
		expect(page).to have_content("Welcome, testdude")
		expect(User.first.email).to eq("test@test.com")
	end

	scenario "with a password that doesn't match" do
		expect {sign_up('a', 'aa', 'a@a.com', 'pass', 'wrong')}.to change(User, :count).by 0
		expect(current_path).to eq('/users')
		expect(page).to have_content("Sorry, your passwords don't match")
	end

	scenario "with an email that is already registered" do
		expect{ sign_up }.to change(User, :count).by(1)
    expect{ sign_up }.to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

end

feature "User signs in" do

	before(:each) do
		User.create(name: "TessTickle",
								username: "testman",
								email: "test@test.co.uk",
								password: "test",
								password_confirmation: "test")
	end

	scenario "with correct credentials" do
		visit '/'
		sign_in("test@test.co.uk", "test")
		expect(page).to have_content("Welcome, testman")
	end

	scenario "with incorrect credentials" do
		visit '/'
		sign_in('test@test.co.uk', 'wrong')
		expect(page).not_to have_content("Welcome, testman")
	end
end

	def sign_up(name = "Tester",
				username = "testdude",
				email = "test@test.com",
				password = "1234",
				password_confirmation = "1234")
		visit '/users/new'
		fill_in :name, with: name
		fill_in :username, with: username
		fill_in :email, with: email
		fill_in :password, with: password
		fill_in :password_confirmation, with: password_confirmation
		click_button "Sign up"
	end
	
	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', with: email
		fill_in 'password', with: password
		click_button 'Sign in'
	end