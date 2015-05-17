include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can create new micropost
feature 'Micropost create', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User creates a new micropost
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I can create a new micropost
  scenario 'user creates a new micropsot' do
    user = create(:user)
    login_as(user, scope: :user)
    visit user_path(user)
    click_button 'New status'
    micropost_content = 'micropost content'
    fill_in 'micropost_content', with: micropost_content
    click_button 'Update status'
    expect(page).to have_content micropost_content
    expect(page.current_path).to eq user_path(user)
  end
end
