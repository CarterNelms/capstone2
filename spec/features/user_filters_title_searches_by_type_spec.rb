# As a user
# In order to find a title of a specific type
# I want to filter my title searches by type

# Usage:

#     User navigates to the title search screen
#     User selects which types he wishes to search / not search
#     User submits his search criteria
#     Only results of the selected type are returned to the user

feature "User filters title searches by type" do

  let!(:user){ Fabricate(:user) }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
    click_link "Titles"
  end

  scenario "Happy Path, User visits his library" do
    fill_in "titles_keywords", with: "lord of the rings"
    uncheck "Books"
    check "Movies"
    uncheck "Video games"
    click_button "Search"
  end
end