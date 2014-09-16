# As a user
# In order to search for titles that may be listed locally
# I want to search all existing titles to see what may be available

# Usage:

#     User navigates to the title search
#     User submits his search criteria
#     An API call based upon the user's criteria finds all matching titles
#     Matching titles are returned to the user

feature "User searches existing titles" do

  let!(:user){ Fabricate(:user) }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
    click_link "Titles"
  end

  scenario "Happy Path, User visits his library" do
    fill_in "Keywords", with: "lord of the rings"
    click_button "Search"

    page.should have_content "The Fellowship of the Ring"
    page.should have_content "The Two Towers"
    page.should have_content "The Return of the King"
  end
end