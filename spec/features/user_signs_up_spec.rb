# As a user
# In order to use this app
# I want to create an account and sign up

# Usage:

#     User visits the site without an account
#     User clicks on the sigh up option
#     User fills out the form with his info and submits
#     A verification email is sent to the user
#     User clicks the link sent to his inbox

feature "Users signs up" do

  before do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign up"
  end

  scenario "Happy Path, Sign Up" do
    current_path.should == root_path
    page.should have_content("Your account was successfully created")

    # click_link "Sign Out"
    # current_path.should == new_user_session_path
    # fill_in "Email", with: "user1@example.com"
    # fill_in "Password", with: "password1"
    # click_button "Sign In"
    # page.should have_content("Welcome back, eliza@example.com!")
  end

  scenario "Happy Path, Verify new account and sign in" do
    # Verify ...
    click_link "Sign In"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  scenario "Skipped email and password" do
    visit '/'
    click_link "Sign Up"
    click_button "Create My Account"
    page.should have_content("Your account could not be created.")
    page.should have_error("can't be blank", on: "Email")
    page.should have_error("can't be blank", on: "Password")
  end
end
