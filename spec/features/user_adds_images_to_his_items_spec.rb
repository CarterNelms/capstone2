# As a user
# In order to display my items
# I want to give add images to my item listings

# Usage:

#     User chooses to add an item to his library or wanted list
#     User uploads an image file(s) or provides a link(s) to an image of the item
#     User submits the new item form

feature "User adds images to his items" do

  let!(:user){ Fabricate(:user) }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  # scenario "Happy Path, User adds an image via url" do
  #   click_link "Profile"
  #   click_link "new_library_item"
  #   fill_in "Item name", with: "Skyrim"
  #   select "Video Game", from: "Item type"
  #   fill_in "Min duration", with: 3
  #   fill_in "Max duration", with: 14
  #   fill_in "Rate", with: 1
  #   fill_in "Description", with: "This item is mine"

  #   click_button "Add New Item"
  #   user.library.items.last.description.should == "This item is mine"
  # end

  scenario "Happy Path, User uploads an image file" do
    click_link "Profile"
    click_link "new_library_item"
    fill_in "Item name", with: "Skyrim"
    select "Video Game", from: "Item type"
    attach_file "item_images", "#{Rails.root}/spec/fixtures/images/blueberry_profile.png"
    fill_in "Min duration", with: 3
    fill_in "Max duration", with: 14
    fill_in "Rate", with: 1
    fill_in "Description", with: "This item is mine"

    click_button "Add New Item"
    item = user.library.items.last
    item.images.class.name.should == "ItemImageUploader"
  end
end

