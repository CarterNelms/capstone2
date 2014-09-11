# As a user
# In order to display my items to other users
# I want to add them to my library

# Usage:

#     User visits his library
#     User selects "New Item"
#     User fills out the form to define what item he has, how much he will rent it for, etc.
#     User submits the form
#     A new item is added to the user's library

feature "User adds an item to his library" do

  let!(:user){ Fabricate(:user) }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  scenario "Happy Path, User visits his library" do
    click_link "Profile"
    click_link "My Library"
    current_path.should == user_libraries_path(user.id)
  end

  scenario "Happy Path, User adds a new item to his library from search" do
    click_link "For Rent"
    
  end
end

