include Warden::Test::Helpers
Warden.test_mode!

# Feature: Following users
#   As a user
#   I want to follow other users
#   So I can see their microposts
feature 'Following users', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User following other users
  #   Given I am signed in
  #   When I visit the users page
  #   Then I can follow other users
  #   Then I can see their microposts
  scenario 'user following other users' do
    me = create(:user)
    other = create(:user)
    login_as(me, scope: :user)

    visit users_path
    find("[action=\"\/#{other.username}\/follow\"]").click_button 'Follow'
    visit user_path(me)
    expect(page).to have_link '1 following'

    visit following_user_path(me)
    expect(page).to have_link other.username
    expect(page).to have_button 'Unfollow'
  end

  # Scenario: User following
  #   Given I am not signed in
  #   When I visit someone's following page
  #   Then I can see users who he follows
  scenario 'user is following users' do
    user = create(:user)
    other = create(:user)
    user.follow! other
    visit following_user_path(user)
    expect(page).to have_link other.username
  end

  # Scenario: User followers
  #   Given I am not signed in
  #   When I visit someone's followers page
  #   Then I can see users who follow him
  scenario 'user has followers' do
    user = create(:user)
    other = create(:user)
    other.follow! user
    visit followers_user_path(user)
    expect(page).to have_link other.username
  end
end
