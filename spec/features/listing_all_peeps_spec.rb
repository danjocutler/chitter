require 'spec_helper'

feature "User browses the peeps" do 
	
	before(:each) {
		Peep.create(:user => "Tester",
					:message => "I like tests")
	}

	scenario "sees the peep" do
		visit '/'
		expect(page).to have_content("I like tests")
	end
	
	scenario "sees who wrote the peep" do
		visit '/'
		expect(page).to have_content("Tester")
	end

end