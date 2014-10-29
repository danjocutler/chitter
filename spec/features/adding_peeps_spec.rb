	require 'spec_helper'

feature "User adds a new peep" do

		before(:each) {
		User.create(name: "Test",
								username: "testman",
								email: "test@test.co.uk",
								password: "test",
								password_confirmation: "test")
	}

	scenario "when browsing the homepage" do
		expect(Peep.count).to eq 0
		visit '/'
		add_peep("I like tests")
		expect(Peep.count).to eq 1
		peep = Peep.first
		expect(peep.message).to eq "I like tests"
	end

	scenario 'cannot peep if signed out' do
		visit '/'
		sign_in('test@test.co.uk', 'test')
		click_button 'Sign out'
		expect(page).not_to have_content('post')
	end

	def add_peep(message) 
			visit '/'
			sign_in('test@test.co.uk', 'test')
			fill_in 'message', with: message
			click_button 'Post'
	end
end