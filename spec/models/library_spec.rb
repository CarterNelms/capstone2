require 'rails_helper'

RSpec.describe Library, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it { should belong_to :user }
  it { pending "items must be implemented"
    should have_many :items }

  context "New user is created" do
    let!(:user) { Fabricate(:user) }
    it "initializes an empty library for the new user" do
      # pending "items must be implemented"
      expect(user.library).not_to be_nil
      expect(user.library.class).to eq Library
      expect(user.library.type).to eq "Library"
    end
  end
end
