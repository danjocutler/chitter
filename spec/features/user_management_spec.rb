require 'spec_helper'

feature "User signs up" do

	scenario "when being logged out" do
		expect {sign_up}.to change(User, :count).by 1
		expect(page).to have_content("Welcome to TwitFace, testdude")
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
		User.create(name: "Test",
								username: "testman",
								email: "test@test.co.uk",
								password: "test",
								password_confirmation: "test")
	end

	scenario "with correct credentials" do
		visit '/'
		sign_in("test@test.co.uk", "test")
		expect(page).to have_content("Welcome to TwitFace, testman")
	end

	scenario "with incorrect credentials" do
		visit '/'
		sign_in('test@test.co.uk', 'wrong')
		expect(page).not_to have_content("Welcome to TwitFace, testman")
	end

end

feature 'User signs out' do

	before(:each) do
		User.create(name: "Test",
								username: "testman",
								email: "test@test.co.uk",
								password: "test",
								password_confirmation: "test")
	end

	scenario 'while being signed in' do
    sign_in('test@test.co.uk', 'test')
    click_button "Sign out"
    expect(page).to have_content("Goodbye!")
    expect(page).not_to have_content("Welcome to TwitFace, testman")
  end

end

