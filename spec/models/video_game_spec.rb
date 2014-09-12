require 'rails_helper'

RSpec.describe VideoGame, :type => :model do

  it { should belong_to :item_list }

  context "Item is added to a user's library" do
    let!(:user) { Fabricate(:user) }
    let!(:video_game) { Fabricate(:video_game) }
    it "successfully saves the item to the user's library" do
      # pending "items must be implemented"
      user.add_to_library(video_game)
      expect(user.library.items).to include(video_game)
      expect(user.library.items[0]).to eq video_game
      expect(user.library.items[0].class).to eq VideoGame
      expect(user.library.items[0].type).to eq "VideoGame"
      expect(video_game.item_list_id).to eq user.library.id
    end
  end
end
