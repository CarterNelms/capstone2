require 'rails_helper'

RSpec.describe Library, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it { should belong_to :user }
  it { should have_many :items }

  context "New user is created" do
    let!(:user) { Fabricate(:user) }
    let!(:movie) { Fabricate(:movie) }
    let!(:item) { Fabricate(:item) }
    let!(:non_item) { { name: "Non Item" } }

    it "initializes an empty library for the new user" do
      # pending "items must be implemented"
      expect(user.library).not_to be_nil
      expect(user.library.class).to eq Library
      expect(user.library.type).to eq "Library"
    end

    it "adds items to the library" do
      user.add_to_library(movie)
      expect(user.library.items).to include(movie)
      expect(user.library.items.length).to eq 1
    end

    it "allows only items that inherited the item class, not raw items" do
      user.add_to_library(item)
      expect(user.library.items).not_to include(item)
      expect(user.library.items.length).to eq 0
    end

    it "does not add non-items to the library" do
      user.add_to_library(non_item)
      expect(user.library.items).not_to include(non_item)
      expect(user.library.items.length).to eq 0
    end
  end
end
