# As a user
# In order to find an item that interests me
# I want to search for it by name

# Usage:

#     User enters the title's name into the search bar and submits
#     All matches are presented to the user on the search page

feature "User searches for an item by name" do

  let!(:user1){ Fabricate(:user) }
  let!(:user2){ Fabricate(:user) }
  let!(:movie1){ Fabricate(:movie) }
  let!(:movie2){ Fabricate(:movie) }
  let!(:movie3){ Fabricate(:movie) }
  let!(:movie4){ Fabricate(:movie) }

  before do
    user1.add_to_library(movie1)
    user1.add_to_library(movie2)
    user1.add_to_wanted_list(movie3)
    user1.add_to_wanted_list(movie4)
    visit new_user_session_path
    fill_in "Email", with: user2.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  scenario "Happy Path, User visits his library" do
    click_link "Listings"
    fill_in "Search Listings", with: movie1.name
  end
end