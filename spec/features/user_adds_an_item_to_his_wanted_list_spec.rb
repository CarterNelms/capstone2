# As a user
# In order to let others know what I want
# I want to add my desired items to my wanted list

# Usage:

#     User visits his wanted list
#     User selects "New Item"
#     User fills out the form to define what item he wants, how much he will rent it for, etc.
#     User submits the form
#     A new item is added to the user's wanted list


feature "User adds an item to his wanted list" do

  let!(:user){ Fabricate(:user) }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  scenario "Happy Path, User adds a new item to his wanted list" do
    click_link "Profile"
    click_link "new_wanted_list_item"
    fill_in "Item name", with: "Skyrim"
    select "Video Game", from: "Item type"
    fill_in "Min duration", with: 3
    fill_in "Max duration", with: 14
    fill_in "Rate", with: 1
    click_button "Add New Item"
    current_path.should == user_path(user.id)
    page.should have_content("Skyrim (Video Game) has successfully been added to your list of wanted items.")
    user.wanted_list.items.length.should eq 1
  end
end

