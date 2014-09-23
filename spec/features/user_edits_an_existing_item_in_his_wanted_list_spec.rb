# As a user
# In order to remove wanted item listings
# I want to delete an item form my wanted list

# Usage:
# * User navigates to his listing that he wishes to delete
# * User clicks on delete button
# * User is prompted to confirm that he wishes to delete the item
# * The item is destroyed in the database
# * The user is redirected to his wanted list

feature "User edits and existing item in his wanted list" do

  let!(:user){ Fabricate(:user) }
  let!(:book){ Fabricate(:book) }

  before do
    user.add_to_library(book)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  scenario "Happy Path, User edits an item" do
    visit user_path(user)

    click_link book.name
    click_button "Edit"
    old_name = book.name
    new_name = "New Name"
    fill_in "Item name", with: new_name
    click_button "Save Changes"

    current_path.should eq user_path(user)
    page.should have_content new_name
    page.should_not have_content old_name
  end
end