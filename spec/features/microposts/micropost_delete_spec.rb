include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I delete my own microposts
feature 'Micropost delete', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User deletes a micropost
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I can delete my micropost
  scenario 'user deletes a micropsot' do
    user = create(:user)
    login_as(user, scope: :user)
    micropost_content = 'micropost content'
    @micropost = create(:micropost, content: micropost_content, user: user)
    visit user_path(user)
    click_link 'delete'
    expect(page).not_to have_content micropost_content
    expect(page.current_path).to eq user_path(user)
    expect(page).to have_content 'Status deleted.'
  end
end
