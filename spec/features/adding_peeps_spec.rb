require 'spec_helper'

feature "User adds a new peep" do
	scenario "when browsing the homepage" do
		expect(Peep.count).to eq 0
		visit '/'
		add_peep("I like tests", "Tester")
		expect(Peep.count).to eq 1
		peep = Peep.first
		expect(peep.message).to eq "I like tests"
	end

	def add_peep(message, user)
		within('#new-peep') do
			fill_in 'message', :with => message
			click_button 'Post'
		end
	end
end