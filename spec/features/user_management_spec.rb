require 'spec_helper'

feature "User signs up" do
	scenario "when being logged out" do
		expect {sign_up}.to change(User, :count).by 1
		expect(page).to have_content("Welcome, testdude")
		expect(User.first.email).to eq("test@test.com")
	end

	scenario "with a password that doesn't match" do
		expect {sign_up('a', 'aa', 'a@a.com', 'pass', 'wrong')}.to change(User, :count).by 0
	end

	def sign_up(name = "Tester",
				username = "testdude",
				email = "test@test.com",
				password = "1234",
				password_confirmation = "1234")
		visit '/users/new'
		fill_in :name, :with => name
		fill_in :username, :with => username
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end
end