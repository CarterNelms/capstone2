# As a user
# In order to restrict my searches to certain media types
# I want to search items by type

# Usage:

#     User visits the search page
#     User specifies the type of item he is looking for
#     User submits his search criteria
#     A list of items of the specified type that match the criteria is given to the user

feature "User searches for an item by type" do

  let!(:user1){ Fabricate(:user) }
  let!(:user2){ Fabricate(:user) }
  let!(:movie1){ Fabricate(:movie) }
  let!(:movie2){ Fabricate(:movie) }
  let!(:book1){ Fabricate(:book) }
  let!(:book2){ Fabricate(:book) }

  before do
    user1.add_to_library(movie1)
    user1.add_to_library(movie2)
    user1.add_to_library(book1)
    user1.add_to_library(book2)
    visit new_user_session_path
    fill_in "Email", with: user2.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  scenario "Happy Path, User visits his library" do
    click_link "Listings"
    select "Type", from: "q_c_0_a_0_name"
    fill_in "q_c_0_v_0_value", with: "Book"
    click_button "Search"
    page.should have_content book1.name
    page.should have_content book2.name
    page.should_not have_content movie1.name
    page.should_not have_content movie2.name
  end
end