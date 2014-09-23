# As a user
# In order to let other users find me
# I want to save my location

# Usage:

#     User chooses to create a new account
#     User fills out the rest of the sign up form
#     User selects to auto-find his location, enters a zip codem, or enters a street address
#     Geocoder stores the user's latitude and longitude in his user model

feature "User records his location on account creation" do

  before do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password1", :match => :prefer_exact
    fill_in "Password confirmation", with: "password1"
    clear_emails
  end

  scenario "Happy Path, User chooses not to include his location" do
    click_button "Sign up"
    user = User.find_by_email("user1@example.com")
    user.latitude.should be nil
    user.longitude.should be nil
  end

  scenario "Happy Path, User chooses to provide his city and state" do
    fill_in "City", with: "Nashville"
    select "Tennessee", from: "State"
    click_button "Sign up"
    user = User.find_by_email("user1@example.com")
    user.latitude.should not_be nil
    user.longitude.should not_be nil
  end
end