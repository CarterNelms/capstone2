require 'rails_helper'

RSpec.describe WantedList, :type => :model do
  
  it { should belong_to :user }
  it { should have_many :items }

  context "New user is created" do
    let!(:user) { Fabricate(:user) }
    let!(:movie) { Fabricate(:movie) }
    let!(:item) { Fabricate(:item) }
    let!(:non_item) { { name: "Non Item" } }

    it "initializes an empty wanted list for the new user" do
      # pending "items must be implemented"
      expect(user.wanted_list).not_to be_nil
      expect(user.wanted_list.class).to eq WantedList
      expect(user.wanted_list.type).to eq "WantedList"
    end

    it "adds items to the wanted list" do
      user.add_to_wanted_list(movie)
      expect(user.wanted_list.items).to include(movie)
      expect(user.wanted_list.items.length).to eq 1
    end

    it "allows only items that inherited the item class, not raw items" do
      user.add_to_wanted_list(item)
      expect(user.wanted_list.items).not_to include(item)
      expect(user.wanted_list.items.length).to eq 0
    end

    it "does not add non-items to the wanted list" do
      user.add_to_wanted_list(non_item)
      expect(user.wanted_list.items).not_to include(non_item)
      expect(user.wanted_list.items.length).to eq 0
    end
  end
end
