include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own username address
  scenario 'user sees own profile' do
    user = create(:user)
    login_as(user, scope: :user)
    visit user_path(user)
    expect(page).to have_content 'User'
    expect(page).to have_content user.username
  end

  # Scenario: User can see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see another user's profile
  scenario "user can see another user's profile" do
    me = create(:user)
    other = create(:user)
    login_as(me, scope: :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit user_path(other)
    expect(page).to have_content 'User'
    expect(page).to have_content other.username
  end
end
