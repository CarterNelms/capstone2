# As a user
# In order to use this app
# I want to create an account and sign up

# Usage:

#     User visits the site without an account
#     User clicks on the sigh up option
#     User fills out the form with his info and submits
#     A verification email is sent to the user
#     User clicks the link sent to his inbox

feature "User signs up" do

  before do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user1@example.com"
    fill_in "Username", with: "User1"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    clear_emails
    click_button "Sign up"
  end

  scenario "Happy Path, Sign Up" do
    current_path.should == root_path
    page.should have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
    User.last.username.should == "User1"

    # click_link "Sign Out"
    # current_path.should == new_user_session_path
    # fill_in "Email", with: "user1@example.com"
    # fill_in "Password", with: "password1"
    # click_button "Sign In"
    # page.should have_content("Welcome back, eliza@example.com!")
  end

  scenario "Happy Path, Verify new account and sign in" do
    User.last.confirmed_at.should be nil
    open_email "user1@example.com"
    current_email.click_link "Confirm my account"
    User.last.confirmed_at.should_not be nil
    page.should have_content("Your email address has been successfully confirmed.")
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign in"
    current_path.should == user_path(User.last)
    page.should have_content("Signed in successfully.")
  end

  scenario "Happy Path, Username can contain spaces, underscores, and hyphens" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user2@example.com"
    fill_in "Username", with: "User -_1"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    clear_emails
    click_button "Sign up"
    User.last.username.should == "User -_1"
  end

  scenario "Skipped email" do
    visit '/'
    click_link "Sign Up"
    fill_in "Username", with: "User1"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    click_button "Sign up"
    page.should have_content("Emailcan't be blank")
  end

  scenario "Skipped password" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user2@example.com"
    fill_in "Username", with: "User1"
    click_button "Sign up"
    page.should have_content("Passwordcan't be blank")
  end

  scenario "Email in use" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user1@example.com"
    fill_in "Username", with: "User1"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    click_button "Sign up"
    page.should have_content("Emailhas already been taken")
  end

  scenario "Username blank" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user2@example.com"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    click_button "Sign up"
    page.should have_content("Username must be at least five (5) characters long")
  end

  scenario "Username too short" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user2@example.com"
    fill_in "Username", with: "Usr1"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    click_button "Sign up"
    page.should have_content("Username must be at least five (5) characters long")
  end

  scenario "Username too long" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user2@example.com"
    fill_in "Username", with: "worldsmostawesomeuser"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    click_button "Sign up"
    page.should have_content("Username must be no more than sixteen (16) characters long")
  end

  # scenario "Username contains invalid characters"
  #   visit '/'
  #   click_link "Sign Up"
  #   fill_in "Email", with: "user2@example.com"
  #   fill_in "Username", with: "Bob!@#$"
  #   fill_in "Password", with: "password1", :match => :prefer_exact
  #   fill_in "Password confirmation", with: "password1"
  #   click_button "Sign up"
  #   page.should have_content("Username can contain letters, numbers, spaces, underscores (_) and dashes (-)")
  #   current_path.should == new_user_registration_path
  # end
end
