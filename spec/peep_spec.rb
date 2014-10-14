require 'spec_helper'

describe Peep do

  context "Demonstration of how datamapper works" do

    # This is not a real test, it's simply a demo of how it works
    it 'should be created and then retrieved from the db' do
      # In the beginning our database is empty, so there are no links
      expect(Peep.count).to eq(0)
      # this creates it in the database, so it's stored on the disk
      Peep.create(:user => "Tester",
                  :message => "This is a test")
      # We ask the database how many links we have, it should be 1
      expect(Peep.count).to eq(1)
      # Let's get the first (and only) peep from the database
      peep = Peep.first
      # Now it has all properties that it was saved with.
      expect(peep.message).to eq("This is a test")
      expect(peep.user).to eq("Tester")
      # If we want to, we can destroy it
      peep.destroy
      # so now we have no peeps in the database
      expect(Peep.count).to eq(0)
    end

  end
end