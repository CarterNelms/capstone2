# As a user
# In order to add existing works to my library
# I want to add items that I found by searching existing titles

# Usage:

#     User searches for the title he wishes to add
#     User clicks to add the desired title as an item to his library
#     The new item form is filled out as mush as possible according to the chosen title

feature "User adds an item from title search to his library" do

  let!(:user){ Fabricate(:user) }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign in"
    click_link "Titles"
  end

  scenario "Happy Path, User adds a title to his library" do

    fill_in "titles_keywords", with: "how i learned to stop worrying and love the bomb"
    uncheck "Books"
    check "Movies"
    uncheck "Video games"
    click_button "Search"
    click_button "I Have This"

    expect(Movie.all.length).to eq 0

    click_button "Add New Item"

    expect(Movie.all.length).to eq 1
    movie = Movie.last
    expect(movie.item_list_id).to eq user.library.id
    expect(movie.name).to eq "Dr. Strangelove Or How I Learned to Stop Worrying and Love the Bomb"
  end
end