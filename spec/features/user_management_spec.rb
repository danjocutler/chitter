require 'spec_helper'

feature "User signs up" do
	scenario "when being logged out" do
		expect {sign_up}.to change(User, :count).by 1
		expect(page).to have_content("Welcome, testdude")
		expect(User.first.email).to eq("test@test.com")
	end

	def sign_up(name = "Tester",
				username = "testdude",
				email = "test@test.com",
				password = "1234")
		visit '/users/new'
		fill_in :name, :with => name
		fill_in :username, :with => username
		fill_in :email, :with => email
		fill_in :password, :with => password
		click_button "Sign up"
	end
end