require 'rails_helper'

RSpec.describe Movie, :type => :model do

  it { should belong_to :item_list }

  context "Item is added to a user's library" do
    let!(:user) { Fabricate(:user) }
    let!(:movie) { Fabricate(:movie) }
    it "successfully saves the item to the user's library" do
      # pending "items must be implemented"
      user.add_to_library(movie)
      expect(user.library.items).to include(movie)
      expect(user.library.items[0]).to eq movie
      expect(user.library.items[0].class).to eq Movie
      expect(user.library.items[0].type).to eq "Movie"
    end
  end
end
