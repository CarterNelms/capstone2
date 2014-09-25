# As a user
# In order to update my personal information
# I want to edit my profile

# Usage:

#     User navigates to his profile
#     User clicks Edit
#     User alters the information on his edit page
#     User submits his new info
#     The user is updated and saved to the database
#     User is redirected to his profile

feature "User edits his profile" do

  before do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    fill_in "Location", with: "Nashville, TN, United States"
    clear_emails
    click_button "Sign up"
    open_email "user1@example.com"
    current_email.click_link "Confirm my account"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign in"
  end

  scenario "Happy Path, User edits his email" do
    click_link "Profile"
    click_link "Edit Profile"
    fill_in "Email", with: "newemail@example.com"
    fill_in "Current password", with: "password1"
    click_button "Update"
    new_user = User.last
    new_user.email.should == "user1@example.com"
    open_email "newemail@example.com"
    current_email.click_link "Confirm my account"
    clear_emails
    User.last.email.should == "newemail@example.com"
  end

  scenario "Happy Path, User edits his password" do
    old_encrypted_password = User.last.encrypted_password
    click_link "Profile"
    click_link "Edit Profile"
    fill_in "Password", with: 'password2', :match => :prefer_exact
    fill_in "Password confirmation", with: "password2"
    fill_in "Current password", with: "password1"
    click_button "Update"
    User.last.encrypted_password.should_not be old_encrypted_password
  end

  scenario "Happy Path, User edits his location" do
    old_user = User.last
    old_user.location.should == "Nashville, TN, United States"
    old_user.latitude.should be 36.166667
    old_user.longitude.should be -86.783333
    click_link "Profile"
    click_link "Edit Profile"
    fill_in "Password", with: '', :match => :prefer_exact
    fill_in "Current password", with: "password1"
    fill_in "Location", with: "Memphis, TN, United States"
    click_button "Update"
    new_user = User.last
    new_user.location.should == "Memphis, TN, United States"
    new_user.latitude.should be 35.1495343
    new_user.longitude.should be -90.0489801
  end

  scenario "User edits no information and no changes are made" do
    old_user = User.last
    click_link "Profile"
    click_link "Edit Profile"
    fill_in "Password", with: '', :match => :prefer_exact
    fill_in "Current password", with: "password1"
    click_button "Update"
    new_user = User.last
    new_user.email.should == old_user.email
    new_user.encrypted_password.should == old_user.encrypted_password
    new_user.location.should == old_user.location
  end

  # This test exists because of a bug that would set current_user to nil
  # if the user attempted and failed to edit his profile
  scenario "current_user is not set to nil upon a failed attempt to edit" do
    old_user = User.first
    click_link "Profile"
    click_link "Edit Profile"
    fill_in "Password", with: 'password2', :match => :prefer_exact
    fill_in "Password confirmation", with: "password2"
    fill_in "Current password", with: "password2"
    click_button "Update"
    fill_in "Password", with: 'password2', :match => :prefer_exact
    fill_in "Password confirmation", with: "password2"
    fill_in "Current password", with: "password1"
    click_button "Update"
    new_user = User.last
    current_path.should == user_path(new_user)
    new_user.encrypted_password.should_not == old_user.encrypted_password
  end
end
