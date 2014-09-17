require 'rails_helper'

RSpec.describe Book, :type => :model do

  it { should belong_to :item_list }

  context "Item is added to a user's library" do
    let!(:user) { Fabricate(:user) }
    let!(:book) { Fabricate(:book) }
    it "successfully saves the item to the user's library" do
      # pending "items must be implemented"
      user.add_to_library(book)
      expect(user.library.items).to include(book)
      expect(user.library.items[0]).to eq book
      expect(user.library.items[0].class).to eq Book
      expect(user.library.items[0].type).to eq "Book"
      expect(book.item_list_id).to eq user.library.id
    end
  end
end
