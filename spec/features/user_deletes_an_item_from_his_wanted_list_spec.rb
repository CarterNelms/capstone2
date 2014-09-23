# As a user
# In order to remove wanted item listings
# I want to delete an item form my wanted list

# Usage:

#     User navigates to his listing that he wishes to delete
#     User clicks on delete button
#     User is prompted to confirm that he wishes to delete the item
#     The item is destroyed in the database
#     The user is redirected to his wanted list

feature "User deletes an item from his wanted list" do

  let!(:user){ Fabricate(:user) }
  let!(:book){ Fabricate(:book) }

  before do
    user.add_to_wanted_list(book)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  scenario "Happy Path, User deletes an item" do
    visit user_path(user)

    page.should have_content book.name

    click_link book.name
    click_button "Delete"
    # click_button "Yes"

    page.should_not have_content book.name
  end
end