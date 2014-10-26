require 'spec_helper'

feature "User browses the peeps" do 
	
	before(:each) {
		User.create(name: "Test",
								username: "testman",
								email: "test@test.co.uk",
								password: "test",
								password_confirmation: "test")		
		Peep.create(message: "I like tests")
	}

	scenario "sees the peep" do
		visit '/'
		click_on 'Sign in'
		sign_in('test@test.co.uk', 'test')
		expect(page).to have_content("I like tests")
	end
	
	scenario "sees who wrote the peep" do
		visit '/'
		click_on 'Sign in'
		sign_in('test@test.co.uk', 'test')		
		expect(page).to have_content("testman")
	end

end