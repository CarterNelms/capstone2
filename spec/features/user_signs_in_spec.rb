# As a user
# In order to use my account with this app
# I want to sign in to my account

# Usage:

#     User has registered and verified his account
#     User clicks on the log in option
#     User enters his email/username with correct password and submits
#     The user's information is validated
#     The user is logged in

feature "User signs in" do

  before do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    click_button "Sign up"
    open_email "user1@example.com"
    current_email.click_link "Confirm my account"
    clear_emails
  end

  scenario "Happy Path, Sign in" do
    current_path.should == new_user_session_path
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign in"
    page.should have_content("Signed in successfully")
  end

  scenario "Happy Path, Sign out" do
    current_path.should == new_user_session_path
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign in"
    click_link "Sign Out"
    page.should have_content("Signed out successfully")
  end

  scenario "Wrong email / password combo" do
    current_path.should == new_user_session_path
    fill_in "Email", with: "user2@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign in"
    page.should have_content("Invalid email address or password")
    current_path.should == new_user_session_path
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password2"
    click_button "Sign in"
    page.should have_content("Invalid email or password")
  end
end
