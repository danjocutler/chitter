require 'spec_helper'

feature "User browses the peeps" do 
	
	before(:each) {
		User.create(name: "Test",
								username: "testman",
								email: "test@test.co.uk",
								password: "test",
								password_confirmation: "test")	
	}

	scenario "sees the peep" do
		visit '/'
		posts_peep("I like tests")
		expect(page).to have_content("I like tests")
	end
	
	scenario "sees who wrote the peep" do
		visit '/'
		click_on 'Sign in'
		sign_in('test@test.co.uk', 'test')		
		expect(page).to have_content("testman")
	end

	def posts_peep(message = "I like tests")
		visit '/'
		sign_in('test@test.co.uk', 'test')
		fill_in 'message', with: 'I like tests'
		click_on 'Post'
	end
end